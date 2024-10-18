import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'student_fees_model.dart'; 

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'student_fees.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE fees_payment(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_name TEXT,
        amount REAL,
        grade INTEGER,
        term TEXT
      )
    ''');


    
  }

  Future<int> insertPayment(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('fees_payment', row);
  }

  Future<List<Map<String, dynamic>>> getPayments() async {
    Database db = await database;
    return await db.query('fees_payment');
  }
  Future<int> deletePayment(int id) async {
  Database db = await database;
  return await db.delete(
    'fees_payment',
    where: 'id = ?',
    whereArgs: [id],
  );
}


Future<int> updatePayment(Map<String, dynamic> row) async {
  Database db = await database;
  int id = row['id'];
  return await db.update(
    'fees_payment',
    row,
    where: 'id = ?',
    whereArgs: [id],
  );
}

}




