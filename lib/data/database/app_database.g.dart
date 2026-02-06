// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SavedRatesTable extends SavedRates
    with TableInfo<$SavedRatesTable, SavedRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _baseCodeMeta = const VerificationMeta(
    'baseCode',
  );
  @override
  late final GeneratedColumn<String> baseCode = GeneratedColumn<String>(
    'base_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCodeMeta = const VerificationMeta(
    'targetCode',
  );
  @override
  late final GeneratedColumn<String> targetCode = GeneratedColumn<String>(
    'target_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCode,
    targetCode,
    rate,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('base_code')) {
      context.handle(
        _baseCodeMeta,
        baseCode.isAcceptableOrUnknown(data['base_code']!, _baseCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_baseCodeMeta);
    }
    if (data.containsKey('target_code')) {
      context.handle(
        _targetCodeMeta,
        targetCode.isAcceptableOrUnknown(data['target_code']!, _targetCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_targetCodeMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedRate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      baseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_code'],
      )!,
      targetCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_code'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $SavedRatesTable createAlias(String alias) {
    return $SavedRatesTable(attachedDatabase, alias);
  }
}

class SavedRate extends DataClass implements Insertable<SavedRate> {
  final int id;
  final String baseCode;
  final String targetCode;
  final double rate;
  final DateTime savedAt;
  const SavedRate({
    required this.id,
    required this.baseCode,
    required this.targetCode,
    required this.rate,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['base_code'] = Variable<String>(baseCode);
    map['target_code'] = Variable<String>(targetCode);
    map['rate'] = Variable<double>(rate);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  SavedRatesCompanion toCompanion(bool nullToAbsent) {
    return SavedRatesCompanion(
      id: Value(id),
      baseCode: Value(baseCode),
      targetCode: Value(targetCode),
      rate: Value(rate),
      savedAt: Value(savedAt),
    );
  }

  factory SavedRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedRate(
      id: serializer.fromJson<int>(json['id']),
      baseCode: serializer.fromJson<String>(json['baseCode']),
      targetCode: serializer.fromJson<String>(json['targetCode']),
      rate: serializer.fromJson<double>(json['rate']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'baseCode': serializer.toJson<String>(baseCode),
      'targetCode': serializer.toJson<String>(targetCode),
      'rate': serializer.toJson<double>(rate),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  SavedRate copyWith({
    int? id,
    String? baseCode,
    String? targetCode,
    double? rate,
    DateTime? savedAt,
  }) => SavedRate(
    id: id ?? this.id,
    baseCode: baseCode ?? this.baseCode,
    targetCode: targetCode ?? this.targetCode,
    rate: rate ?? this.rate,
    savedAt: savedAt ?? this.savedAt,
  );
  SavedRate copyWithCompanion(SavedRatesCompanion data) {
    return SavedRate(
      id: data.id.present ? data.id.value : this.id,
      baseCode: data.baseCode.present ? data.baseCode.value : this.baseCode,
      targetCode: data.targetCode.present
          ? data.targetCode.value
          : this.targetCode,
      rate: data.rate.present ? data.rate.value : this.rate,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedRate(')
          ..write('id: $id, ')
          ..write('baseCode: $baseCode, ')
          ..write('targetCode: $targetCode, ')
          ..write('rate: $rate, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, baseCode, targetCode, rate, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedRate &&
          other.id == this.id &&
          other.baseCode == this.baseCode &&
          other.targetCode == this.targetCode &&
          other.rate == this.rate &&
          other.savedAt == this.savedAt);
}

class SavedRatesCompanion extends UpdateCompanion<SavedRate> {
  final Value<int> id;
  final Value<String> baseCode;
  final Value<String> targetCode;
  final Value<double> rate;
  final Value<DateTime> savedAt;
  const SavedRatesCompanion({
    this.id = const Value.absent(),
    this.baseCode = const Value.absent(),
    this.targetCode = const Value.absent(),
    this.rate = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  SavedRatesCompanion.insert({
    this.id = const Value.absent(),
    required String baseCode,
    required String targetCode,
    required double rate,
    required DateTime savedAt,
  }) : baseCode = Value(baseCode),
       targetCode = Value(targetCode),
       rate = Value(rate),
       savedAt = Value(savedAt);
  static Insertable<SavedRate> custom({
    Expression<int>? id,
    Expression<String>? baseCode,
    Expression<String>? targetCode,
    Expression<double>? rate,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCode != null) 'base_code': baseCode,
      if (targetCode != null) 'target_code': targetCode,
      if (rate != null) 'rate': rate,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  SavedRatesCompanion copyWith({
    Value<int>? id,
    Value<String>? baseCode,
    Value<String>? targetCode,
    Value<double>? rate,
    Value<DateTime>? savedAt,
  }) {
    return SavedRatesCompanion(
      id: id ?? this.id,
      baseCode: baseCode ?? this.baseCode,
      targetCode: targetCode ?? this.targetCode,
      rate: rate ?? this.rate,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (baseCode.present) {
      map['base_code'] = Variable<String>(baseCode.value);
    }
    if (targetCode.present) {
      map['target_code'] = Variable<String>(targetCode.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedRatesCompanion(')
          ..write('id: $id, ')
          ..write('baseCode: $baseCode, ')
          ..write('targetCode: $targetCode, ')
          ..write('rate: $rate, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

class $WatchedCurrenciesTable extends WatchedCurrencies
    with TableInfo<$WatchedCurrenciesTable, WatchedCurrency> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchedCurrenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, currencyCode, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'watched_currencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<WatchedCurrency> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {currencyCode},
  ];
  @override
  WatchedCurrency map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WatchedCurrency(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $WatchedCurrenciesTable createAlias(String alias) {
    return $WatchedCurrenciesTable(attachedDatabase, alias);
  }
}

class WatchedCurrency extends DataClass implements Insertable<WatchedCurrency> {
  final int id;
  final String currencyCode;
  final int sortOrder;
  const WatchedCurrency({
    required this.id,
    required this.currencyCode,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_code'] = Variable<String>(currencyCode);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  WatchedCurrenciesCompanion toCompanion(bool nullToAbsent) {
    return WatchedCurrenciesCompanion(
      id: Value(id),
      currencyCode: Value(currencyCode),
      sortOrder: Value(sortOrder),
    );
  }

  factory WatchedCurrency.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchedCurrency(
      id: serializer.fromJson<int>(json['id']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  WatchedCurrency copyWith({int? id, String? currencyCode, int? sortOrder}) =>
      WatchedCurrency(
        id: id ?? this.id,
        currencyCode: currencyCode ?? this.currencyCode,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  WatchedCurrency copyWithCompanion(WatchedCurrenciesCompanion data) {
    return WatchedCurrency(
      id: data.id.present ? data.id.value : this.id,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WatchedCurrency(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currencyCode, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchedCurrency &&
          other.id == this.id &&
          other.currencyCode == this.currencyCode &&
          other.sortOrder == this.sortOrder);
}

class WatchedCurrenciesCompanion extends UpdateCompanion<WatchedCurrency> {
  final Value<int> id;
  final Value<String> currencyCode;
  final Value<int> sortOrder;
  const WatchedCurrenciesCompanion({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  WatchedCurrenciesCompanion.insert({
    this.id = const Value.absent(),
    required String currencyCode,
    this.sortOrder = const Value.absent(),
  }) : currencyCode = Value(currencyCode);
  static Insertable<WatchedCurrency> custom({
    Expression<int>? id,
    Expression<String>? currencyCode,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  WatchedCurrenciesCompanion copyWith({
    Value<int>? id,
    Value<String>? currencyCode,
    Value<int>? sortOrder,
  }) {
    return WatchedCurrenciesCompanion(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchedCurrenciesCompanion(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedRatesTable savedRates = $SavedRatesTable(this);
  late final $WatchedCurrenciesTable watchedCurrencies =
      $WatchedCurrenciesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    savedRates,
    watchedCurrencies,
  ];
}

typedef $$SavedRatesTableCreateCompanionBuilder =
    SavedRatesCompanion Function({
      Value<int> id,
      required String baseCode,
      required String targetCode,
      required double rate,
      required DateTime savedAt,
    });
typedef $$SavedRatesTableUpdateCompanionBuilder =
    SavedRatesCompanion Function({
      Value<int> id,
      Value<String> baseCode,
      Value<String> targetCode,
      Value<double> rate,
      Value<DateTime> savedAt,
    });

class $$SavedRatesTableFilterComposer
    extends Composer<_$AppDatabase, $SavedRatesTable> {
  $$SavedRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCode => $composableBuilder(
    column: $table.baseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetCode => $composableBuilder(
    column: $table.targetCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedRatesTable> {
  $$SavedRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCode => $composableBuilder(
    column: $table.baseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetCode => $composableBuilder(
    column: $table.targetCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedRatesTable> {
  $$SavedRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseCode =>
      $composableBuilder(column: $table.baseCode, builder: (column) => column);

  GeneratedColumn<String> get targetCode => $composableBuilder(
    column: $table.targetCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedRatesTable,
          SavedRate,
          $$SavedRatesTableFilterComposer,
          $$SavedRatesTableOrderingComposer,
          $$SavedRatesTableAnnotationComposer,
          $$SavedRatesTableCreateCompanionBuilder,
          $$SavedRatesTableUpdateCompanionBuilder,
          (
            SavedRate,
            BaseReferences<_$AppDatabase, $SavedRatesTable, SavedRate>,
          ),
          SavedRate,
          PrefetchHooks Function()
        > {
  $$SavedRatesTableTableManager(_$AppDatabase db, $SavedRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> baseCode = const Value.absent(),
                Value<String> targetCode = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => SavedRatesCompanion(
                id: id,
                baseCode: baseCode,
                targetCode: targetCode,
                rate: rate,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String baseCode,
                required String targetCode,
                required double rate,
                required DateTime savedAt,
              }) => SavedRatesCompanion.insert(
                id: id,
                baseCode: baseCode,
                targetCode: targetCode,
                rate: rate,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedRatesTable,
      SavedRate,
      $$SavedRatesTableFilterComposer,
      $$SavedRatesTableOrderingComposer,
      $$SavedRatesTableAnnotationComposer,
      $$SavedRatesTableCreateCompanionBuilder,
      $$SavedRatesTableUpdateCompanionBuilder,
      (SavedRate, BaseReferences<_$AppDatabase, $SavedRatesTable, SavedRate>),
      SavedRate,
      PrefetchHooks Function()
    >;
typedef $$WatchedCurrenciesTableCreateCompanionBuilder =
    WatchedCurrenciesCompanion Function({
      Value<int> id,
      required String currencyCode,
      Value<int> sortOrder,
    });
typedef $$WatchedCurrenciesTableUpdateCompanionBuilder =
    WatchedCurrenciesCompanion Function({
      Value<int> id,
      Value<String> currencyCode,
      Value<int> sortOrder,
    });

class $$WatchedCurrenciesTableFilterComposer
    extends Composer<_$AppDatabase, $WatchedCurrenciesTable> {
  $$WatchedCurrenciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WatchedCurrenciesTableOrderingComposer
    extends Composer<_$AppDatabase, $WatchedCurrenciesTable> {
  $$WatchedCurrenciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WatchedCurrenciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WatchedCurrenciesTable> {
  $$WatchedCurrenciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$WatchedCurrenciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WatchedCurrenciesTable,
          WatchedCurrency,
          $$WatchedCurrenciesTableFilterComposer,
          $$WatchedCurrenciesTableOrderingComposer,
          $$WatchedCurrenciesTableAnnotationComposer,
          $$WatchedCurrenciesTableCreateCompanionBuilder,
          $$WatchedCurrenciesTableUpdateCompanionBuilder,
          (
            WatchedCurrency,
            BaseReferences<
              _$AppDatabase,
              $WatchedCurrenciesTable,
              WatchedCurrency
            >,
          ),
          WatchedCurrency,
          PrefetchHooks Function()
        > {
  $$WatchedCurrenciesTableTableManager(
    _$AppDatabase db,
    $WatchedCurrenciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WatchedCurrenciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WatchedCurrenciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WatchedCurrenciesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => WatchedCurrenciesCompanion(
                id: id,
                currencyCode: currencyCode,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String currencyCode,
                Value<int> sortOrder = const Value.absent(),
              }) => WatchedCurrenciesCompanion.insert(
                id: id,
                currencyCode: currencyCode,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WatchedCurrenciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WatchedCurrenciesTable,
      WatchedCurrency,
      $$WatchedCurrenciesTableFilterComposer,
      $$WatchedCurrenciesTableOrderingComposer,
      $$WatchedCurrenciesTableAnnotationComposer,
      $$WatchedCurrenciesTableCreateCompanionBuilder,
      $$WatchedCurrenciesTableUpdateCompanionBuilder,
      (
        WatchedCurrency,
        BaseReferences<_$AppDatabase, $WatchedCurrenciesTable, WatchedCurrency>,
      ),
      WatchedCurrency,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedRatesTableTableManager get savedRates =>
      $$SavedRatesTableTableManager(_db, _db.savedRates);
  $$WatchedCurrenciesTableTableManager get watchedCurrencies =>
      $$WatchedCurrenciesTableTableManager(_db, _db.watchedCurrencies);
}
