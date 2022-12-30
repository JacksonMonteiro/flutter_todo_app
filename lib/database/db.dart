import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // Singleton
  static final instance = DB._();
  DB._();

  // SQLITE instance
  static Database? _database;

  // Tables
  String get _categories => '''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      codePoint TEXT, 
      name TEXT, 
      tasks INTEGER
    )
  ''';

  String get _tasks => '''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT, 
      category TEXT 
    )
  ''';

  // Functions
  get database async {
    if (_database != null) return _database;
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_categories); 
    await db.execute(_tasks);
  }
}