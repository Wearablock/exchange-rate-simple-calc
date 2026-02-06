import 'package:flutter/foundation.dart';
import '../../data/database/app_database.dart';

class RateHistoryService {
  // ============================================================
  // 싱글톤 패턴
  // ============================================================

  static final RateHistoryService _instance = RateHistoryService._internal();
  factory RateHistoryService() => _instance;
  RateHistoryService._internal();

  final AppDatabase _db = AppDatabase();

  // ============================================================
  // 환율 저장
  // ============================================================

  /// 환율 저장
  Future<int> saveRate({
    required String baseCode,
    required String targetCode,
    required double rate,
  }) async {
    final id = await _db.insertSavedRate(
      SavedRatesCompanion.insert(
        baseCode: baseCode,
        targetCode: targetCode,
        rate: rate,
        savedAt: DateTime.now(),
      ),
    );

    debugPrint('[RateHistoryService] 환율 저장: $baseCode→$targetCode = $rate');
    return id;
  }

  /// 모든 기록 조회
  Future<List<SavedRate>> getAllRecords() {
    return _db.getAllSavedRates();
  }

  /// 기록 스트림
  Stream<List<SavedRate>> watchAllRecords() {
    return _db.watchAllSavedRates();
  }

  /// 월별 기록 조회
  Future<List<SavedRate>> getRecordsByMonth(int year, int month) {
    return _db.getSavedRatesByMonth(year, month);
  }

  /// 특정 통화쌍 기록 조회
  Future<List<SavedRate>> getRecordsByPair(String baseCode, String targetCode) {
    return _db.getSavedRatesByPair(baseCode, targetCode);
  }

  /// 기록 삭제
  Future<void> deleteRecord(int id) async {
    await _db.deleteSavedRate(id);
    debugPrint('[RateHistoryService] 기록 삭제: $id');
  }

  /// 모든 기록 삭제
  Future<void> deleteAllRecords() async {
    await _db.deleteAllSavedRates();
    debugPrint('[RateHistoryService] 모든 기록 삭제');
  }

  /// 기록 개수
  Future<int> getRecordsCount() {
    return _db.getSavedRatesCount();
  }

  // ============================================================
  // 관심 통화
  // ============================================================

  /// 관심 통화 목록 조회
  Future<List<String>> getWatchList() {
    return _db.getWatchedCurrencyCodes();
  }

  /// 관심 통화 스트림
  Stream<List<WatchedCurrency>> watchWatchList() {
    return _db.watchAllWatchedCurrencies();
  }

  /// 관심 통화 코드 스트림
  Stream<List<String>> watchWatchListCodes() {
    return _db.watchWatchedCurrencyCodes();
  }

  /// 관심 통화 추가
  Future<void> addToWatchList(String currencyCode) async {
    final exists = await _db.isWatchedCurrency(currencyCode);
    if (!exists) {
      await _db.addWatchedCurrency(currencyCode);
      debugPrint('[RateHistoryService] 관심 통화 추가: $currencyCode');
    }
  }

  /// 관심 통화 삭제
  Future<void> removeFromWatchList(String currencyCode) async {
    await _db.removeWatchedCurrency(currencyCode);
    debugPrint('[RateHistoryService] 관심 통화 삭제: $currencyCode');
  }

  /// 관심 통화 순서 변경
  Future<void> reorderWatchList(List<String> orderedCodes) {
    return _db.reorderWatchedCurrencies(orderedCodes);
  }

  /// 관심 통화 존재 여부 확인
  Future<bool> isInWatchList(String currencyCode) {
    return _db.isWatchedCurrency(currencyCode);
  }

  /// 기본 관심 통화 초기화
  Future<void> initializeDefaults(List<String> defaults) {
    return _db.initializeDefaultWatchList(defaults);
  }

  /// 관심 통화 전체 삭제
  Future<void> clearWatchList() async {
    await _db.removeAllWatchedCurrencies();
    debugPrint('[RateHistoryService] 관심 통화 전체 삭제');
  }

  /// 관심 통화 설정 (기존 삭제 후 새로 설정)
  Future<void> setWatchList(List<String> currencyCodes) async {
    await _db.removeAllWatchedCurrencies();
    for (int i = 0; i < currencyCodes.length; i++) {
      await _db.addWatchedCurrency(currencyCodes[i]);
    }
    debugPrint('[RateHistoryService] 관심 통화 설정: $currencyCodes');
  }
}
