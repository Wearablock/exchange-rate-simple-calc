import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ============================================================
// 테이블 정의
// ============================================================

/// 저장된 환율 기록
class SavedRates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get baseCode => text().withLength(min: 3, max: 3)();
  TextColumn get targetCode => text().withLength(min: 3, max: 3)();
  RealColumn get rate => real()();
  DateTimeColumn get savedAt => dateTime()();
}

/// 관심 통화 목록
class WatchedCurrencies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {currencyCode}
      ];
}

// ============================================================
// 데이터베이스 클래스
// ============================================================

@DriftDatabase(tables: [SavedRates, WatchedCurrencies])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 테스트용 생성자
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await customStatement('ALTER TABLE saved_rates DROP COLUMN memo');
      }
    },
  );

  // ============================================================
  // 저장된 환율 기록 CRUD
  // ============================================================

  /// 환율 저장
  Future<int> insertSavedRate(SavedRatesCompanion rate) {
    return into(savedRates).insert(rate);
  }

  /// 모든 저장 기록 조회 (최신순)
  Future<List<SavedRate>> getAllSavedRates() {
    return (select(savedRates)
          ..orderBy([
            (t) => OrderingTerm(expression: t.savedAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  /// 특정 통화쌍 기록 조회
  Future<List<SavedRate>> getSavedRatesByPair(
    String baseCode,
    String targetCode,
  ) {
    return (select(savedRates)
          ..where(
              (t) => t.baseCode.equals(baseCode) & t.targetCode.equals(targetCode))
          ..orderBy([
            (t) => OrderingTerm(expression: t.savedAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  /// 월별 기록 조회
  Future<List<SavedRate>> getSavedRatesByMonth(int year, int month) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    return (select(savedRates)
          ..where((t) =>
              t.savedAt.isBiggerOrEqualValue(startDate) &
              t.savedAt.isSmallerOrEqualValue(endDate))
          ..orderBy([
            (t) => OrderingTerm(expression: t.savedAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  /// 기록 삭제
  Future<int> deleteSavedRate(int id) {
    return (delete(savedRates)..where((t) => t.id.equals(id))).go();
  }

  /// 모든 기록 삭제
  Future<int> deleteAllSavedRates() {
    return delete(savedRates).go();
  }

  /// 기록 스트림 (실시간 업데이트)
  Stream<List<SavedRate>> watchAllSavedRates() {
    return (select(savedRates)
          ..orderBy([
            (t) => OrderingTerm(expression: t.savedAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  /// 기록 개수
  Future<int> getSavedRatesCount() async {
    final count = countAll();
    final query = selectOnly(savedRates)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  // ============================================================
  // 관심 통화 CRUD
  // ============================================================

  /// 관심 통화 추가
  Future<int> addWatchedCurrency(String currencyCode) async {
    final maxOrder = await _getMaxSortOrder();
    return into(watchedCurrencies).insert(
      WatchedCurrenciesCompanion.insert(
        currencyCode: currencyCode,
        sortOrder: Value(maxOrder + 1),
      ),
    );
  }

  Future<int> _getMaxSortOrder() async {
    final result = await customSelect(
      'SELECT MAX(sort_order) as max_order FROM watched_currencies',
    ).getSingleOrNull();
    return result?.read<int?>('max_order') ?? 0;
  }

  /// 모든 관심 통화 조회
  Future<List<WatchedCurrency>> getAllWatchedCurrencies() {
    return (select(watchedCurrencies)
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
  }

  /// 관심 통화 코드 목록만 조회
  Future<List<String>> getWatchedCurrencyCodes() async {
    final currencies = await getAllWatchedCurrencies();
    return currencies.map((c) => c.currencyCode).toList();
  }

  /// 관심 통화 삭제
  Future<int> removeWatchedCurrency(String currencyCode) {
    return (delete(watchedCurrencies)
          ..where((t) => t.currencyCode.equals(currencyCode)))
        .go();
  }

  /// 모든 관심 통화 삭제
  Future<int> removeAllWatchedCurrencies() {
    return delete(watchedCurrencies).go();
  }

  /// 관심 통화 순서 변경
  Future<void> reorderWatchedCurrencies(List<String> orderedCodes) async {
    await transaction(() async {
      for (int i = 0; i < orderedCodes.length; i++) {
        await (update(watchedCurrencies)
              ..where((t) => t.currencyCode.equals(orderedCodes[i])))
            .write(WatchedCurrenciesCompanion(sortOrder: Value(i)));
      }
    });
  }

  /// 관심 통화 존재 여부 확인
  Future<bool> isWatchedCurrency(String currencyCode) async {
    final result = await (select(watchedCurrencies)
          ..where((t) => t.currencyCode.equals(currencyCode)))
        .getSingleOrNull();
    return result != null;
  }

  /// 관심 통화 스트림
  Stream<List<WatchedCurrency>> watchAllWatchedCurrencies() {
    return (select(watchedCurrencies)
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .watch();
  }

  /// 관심 통화 코드 스트림
  Stream<List<String>> watchWatchedCurrencyCodes() {
    return watchAllWatchedCurrencies()
        .map((list) => list.map((c) => c.currencyCode).toList());
  }

  // ============================================================
  // 기본 관심 통화 초기화
  // ============================================================

  Future<void> initializeDefaultWatchList(List<String> defaultCurrencies) async {
    final existing = await getAllWatchedCurrencies();
    if (existing.isEmpty) {
      for (int i = 0; i < defaultCurrencies.length; i++) {
        await into(watchedCurrencies).insert(
          WatchedCurrenciesCompanion.insert(
            currencyCode: defaultCurrencies[i],
            sortOrder: Value(i),
          ),
        );
      }
    }
  }
}

// ============================================================
// 데이터베이스 연결
// ============================================================

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'exchange_rate.db'));
    return NativeDatabase.createInBackground(file);
  });
}
