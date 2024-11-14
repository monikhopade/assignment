import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createDatabase();
      return _database!;
    }
  }

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'user_data.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT,
            last_name TEXT,
            mobile_number TEXT,
            dob TEXT)''');
      },
    );
  }

  Future<int> insertUserDataInDB(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getUsersData(int offset, int limit) async {
    final db = await database;
    return await db.query(
      'users',
      offset: offset,
      limit: limit,
      orderBy: 'id DESC',
    );
  }

  Future<int> countUsers() async {
    final db = await database;
    var result = await db.rawQuery('SELECT COUNT(*) FROM users');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
