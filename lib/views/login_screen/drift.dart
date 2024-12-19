import 'package:drift/drift.dart';


@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get companyId => integer()();
  TextColumn get companyName => text().withLength(min: 1, max: 100)();
  TextColumn get address => text().withLength(min: 1, max: 200)();
  TextColumn get mobile => text().withLength(min: 1, max: 20)();
  TextColumn get userName => text().withLength(min: 1, max: 50)();
  TextColumn get password => text().withLength(min: 1, max: 100)();
  TextColumn get error => text().withLength(min: 1, max: 100)();
}


