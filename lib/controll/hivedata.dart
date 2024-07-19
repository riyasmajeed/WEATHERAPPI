import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'weather.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city TEXT,
        temperature TEXT,
        condition TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertWeather(String city, String temperature, String condition, String date) async {
    final db = await database;
    await db.insert('weather', {
      'city': city,
      'temperature': temperature,
      'condition': condition,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getWeather(String city) async {
    final db = await database;
    return await db.query('weather', where: 'city = ?', whereArgs: [city]);
  }

  Future<void> deleteWeather(String city) async {
    final db = await database;
    await db.delete('weather', where: 'city = ?', whereArgs: [city]);
  }
}
