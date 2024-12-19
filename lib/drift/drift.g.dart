// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $CompanyDataTable extends CompanyData
    with TableInfo<$CompanyDataTable, CompanyDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
      'mobile', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [companyId, companyName, address, mobile, userName, password, error];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_data';
  @override
  VerificationContext validateIntegrity(Insertable<CompanyDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('mobile')) {
      context.handle(_mobileMeta,
          mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta));
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    } else if (isInserting) {
      context.missing(_errorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CompanyDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyDataData(
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id'])!,
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      mobile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mobile'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error'])!,
    );
  }

  @override
  $CompanyDataTable createAlias(String alias) {
    return $CompanyDataTable(attachedDatabase, alias);
  }
}

class CompanyDataData extends DataClass implements Insertable<CompanyDataData> {
  final int companyId;
  final String companyName;
  final String address;
  final String mobile;
  final String userName;
  final String password;
  final String error;
  const CompanyDataData(
      {required this.companyId,
      required this.companyName,
      required this.address,
      required this.mobile,
      required this.userName,
      required this.password,
      required this.error});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['company_id'] = Variable<int>(companyId);
    map['company_name'] = Variable<String>(companyName);
    map['address'] = Variable<String>(address);
    map['mobile'] = Variable<String>(mobile);
    map['user_name'] = Variable<String>(userName);
    map['password'] = Variable<String>(password);
    map['error'] = Variable<String>(error);
    return map;
  }

  CompanyDataCompanion toCompanion(bool nullToAbsent) {
    return CompanyDataCompanion(
      companyId: Value(companyId),
      companyName: Value(companyName),
      address: Value(address),
      mobile: Value(mobile),
      userName: Value(userName),
      password: Value(password),
      error: Value(error),
    );
  }

  factory CompanyDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyDataData(
      companyId: serializer.fromJson<int>(json['companyId']),
      companyName: serializer.fromJson<String>(json['companyName']),
      address: serializer.fromJson<String>(json['address']),
      mobile: serializer.fromJson<String>(json['mobile']),
      userName: serializer.fromJson<String>(json['userName']),
      password: serializer.fromJson<String>(json['password']),
      error: serializer.fromJson<String>(json['error']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'companyId': serializer.toJson<int>(companyId),
      'companyName': serializer.toJson<String>(companyName),
      'address': serializer.toJson<String>(address),
      'mobile': serializer.toJson<String>(mobile),
      'userName': serializer.toJson<String>(userName),
      'password': serializer.toJson<String>(password),
      'error': serializer.toJson<String>(error),
    };
  }

  CompanyDataData copyWith(
          {int? companyId,
          String? companyName,
          String? address,
          String? mobile,
          String? userName,
          String? password,
          String? error}) =>
      CompanyDataData(
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        address: address ?? this.address,
        mobile: mobile ?? this.mobile,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        error: error ?? this.error,
      );
  @override
  String toString() {
    return (StringBuffer('CompanyDataData(')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('address: $address, ')
          ..write('mobile: $mobile, ')
          ..write('userName: $userName, ')
          ..write('password: $password, ')
          ..write('error: $error')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      companyId, companyName, address, mobile, userName, password, error);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyDataData &&
          other.companyId == this.companyId &&
          other.companyName == this.companyName &&
          other.address == this.address &&
          other.mobile == this.mobile &&
          other.userName == this.userName &&
          other.password == this.password &&
          other.error == this.error);
}

class CompanyDataCompanion extends UpdateCompanion<CompanyDataData> {
  final Value<int> companyId;
  final Value<String> companyName;
  final Value<String> address;
  final Value<String> mobile;
  final Value<String> userName;
  final Value<String> password;
  final Value<String> error;
  final Value<int> rowid;
  const CompanyDataCompanion({
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.address = const Value.absent(),
    this.mobile = const Value.absent(),
    this.userName = const Value.absent(),
    this.password = const Value.absent(),
    this.error = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompanyDataCompanion.insert({
    required int companyId,
    required String companyName,
    required String address,
    required String mobile,
    required String userName,
    required String password,
    required String error,
    this.rowid = const Value.absent(),
  })  : companyId = Value(companyId),
        companyName = Value(companyName),
        address = Value(address),
        mobile = Value(mobile),
        userName = Value(userName),
        password = Value(password),
        error = Value(error);
  static Insertable<CompanyDataData> custom({
    Expression<int>? companyId,
    Expression<String>? companyName,
    Expression<String>? address,
    Expression<String>? mobile,
    Expression<String>? userName,
    Expression<String>? password,
    Expression<String>? error,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (companyId != null) 'company_id': companyId,
      if (companyName != null) 'company_name': companyName,
      if (address != null) 'address': address,
      if (mobile != null) 'mobile': mobile,
      if (userName != null) 'user_name': userName,
      if (password != null) 'password': password,
      if (error != null) 'error': error,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompanyDataCompanion copyWith(
      {Value<int>? companyId,
      Value<String>? companyName,
      Value<String>? address,
      Value<String>? mobile,
      Value<String>? userName,
      Value<String>? password,
      Value<String>? error,
      Value<int>? rowid}) {
    return CompanyDataCompanion(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      address: address ?? this.address,
      mobile: mobile ?? this.mobile,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      error: error ?? this.error,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyDataCompanion(')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('address: $address, ')
          ..write('mobile: $mobile, ')
          ..write('userName: $userName, ')
          ..write('password: $password, ')
          ..write('error: $error, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  _$DatabaseManager get managers => _$DatabaseManager(this);
  late final $CompanyDataTable companyData = $CompanyDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [companyData];
}

typedef $$CompanyDataTableInsertCompanionBuilder = CompanyDataCompanion
    Function({
  required int companyId,
  required String companyName,
  required String address,
  required String mobile,
  required String userName,
  required String password,
  required String error,
  Value<int> rowid,
});
typedef $$CompanyDataTableUpdateCompanionBuilder = CompanyDataCompanion
    Function({
  Value<int> companyId,
  Value<String> companyName,
  Value<String> address,
  Value<String> mobile,
  Value<String> userName,
  Value<String> password,
  Value<String> error,
  Value<int> rowid,
});

class $$CompanyDataTableTableManager extends RootTableManager<
    _$Database,
    $CompanyDataTable,
    CompanyDataData,
    $$CompanyDataTableFilterComposer,
    $$CompanyDataTableOrderingComposer,
    $$CompanyDataTableProcessedTableManager,
    $$CompanyDataTableInsertCompanionBuilder,
    $$CompanyDataTableUpdateCompanionBuilder> {
  $$CompanyDataTableTableManager(_$Database db, $CompanyDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CompanyDataTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CompanyDataTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CompanyDataTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> companyId = const Value.absent(),
            Value<String> companyName = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> mobile = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<String> error = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyDataCompanion(
            companyId: companyId,
            companyName: companyName,
            address: address,
            mobile: mobile,
            userName: userName,
            password: password,
            error: error,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required int companyId,
            required String companyName,
            required String address,
            required String mobile,
            required String userName,
            required String password,
            required String error,
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyDataCompanion.insert(
            companyId: companyId,
            companyName: companyName,
            address: address,
            mobile: mobile,
            userName: userName,
            password: password,
            error: error,
            rowid: rowid,
          ),
        ));
}

class $$CompanyDataTableProcessedTableManager extends ProcessedTableManager<
    _$Database,
    $CompanyDataTable,
    CompanyDataData,
    $$CompanyDataTableFilterComposer,
    $$CompanyDataTableOrderingComposer,
    $$CompanyDataTableProcessedTableManager,
    $$CompanyDataTableInsertCompanionBuilder,
    $$CompanyDataTableUpdateCompanionBuilder> {
  $$CompanyDataTableProcessedTableManager(super.$state);
}

class $$CompanyDataTableFilterComposer
    extends FilterComposer<_$Database, $CompanyDataTable> {
  $$CompanyDataTableFilterComposer(super.$state);
  ColumnFilters<int> get companyId => $state.composableBuilder(
      column: $state.table.companyId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get companyName => $state.composableBuilder(
      column: $state.table.companyName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mobile => $state.composableBuilder(
      column: $state.table.mobile,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userName => $state.composableBuilder(
      column: $state.table.userName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CompanyDataTableOrderingComposer
    extends OrderingComposer<_$Database, $CompanyDataTable> {
  $$CompanyDataTableOrderingComposer(super.$state);
  ColumnOrderings<int> get companyId => $state.composableBuilder(
      column: $state.table.companyId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get companyName => $state.composableBuilder(
      column: $state.table.companyName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mobile => $state.composableBuilder(
      column: $state.table.mobile,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userName => $state.composableBuilder(
      column: $state.table.userName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$DatabaseManager {
  final _$Database _db;
  _$DatabaseManager(this._db);
  $$CompanyDataTableTableManager get companyData =>
      $$CompanyDataTableTableManager(_db, _db.companyData);
}
