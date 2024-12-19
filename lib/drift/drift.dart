

import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift.g.dart';

class CompanyData extends Table {
  IntColumn get companyId => integer().autoIncrement()();
  TextColumn get companyName => text()();
  TextColumn get address => text()();
  TextColumn get mobile => text()();
  TextColumn get userName => text()();
  TextColumn get password => text()();
  TextColumn get error => text()();
}

@DriftDatabase(tables: [CompanyData])
class  Database extends _$Database {
  Database( ):super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addCompanyData(CompanyDataCompanion companyData) async {
    log('${companyData.userName}', name: "adding item to db");
    log('${companyData.password}', name: "adding item to db");

    return await into(this.companyData).insert(companyData);
  }
  //  Future<CompanyDataData?> getCompanyData(String userName, String password) =>
  //     (select(companyData)
  //           ..where((tbl) => tbl.userName.equals(userName) & tbl.password.equals(password)))
  //         .getSingleOrNull();

  Future<CompanyDataData?> getCompanyData(String userName, String password) async {
  try {
    return await (select(companyData)
      ..where((tbl) => tbl.userName.equals(userName) & tbl.password.equals(password)))
      .getSingleOrNull();
  } catch (e) {
    print('Error fetching company data: $e');
    return null;
  }
}

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}





