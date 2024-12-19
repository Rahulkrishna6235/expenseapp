import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'modal.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'company_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE companies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        companyId INTEGER,
        companyName TEXT,
        address TEXT,
        mobile TEXT,
        userName TEXT,
        password TEXT,
        error TEXT
      )
    ''');
  }

  Future<int> insertCompany(Company company) async {
    Database db = await database;
    return await db.insert('companies', company.toMap());
  }

  Future<List<Company>> getCompanies() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('companies');
    return List.generate(maps.length, (i) {
      return Company.fromMap(maps[i]);
    });
  }

  Future<int> updateCompany(Company company) async {
    Database db = await database;
    return await db.update(
      'companies',
      company.toMap(),
      where: 'id = ?',
      whereArgs: [company.id],
    );
  }

  Future<int> deleteCompany(int id) async {
    Database db = await database;
    return await db.delete(
      'companies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
