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
    return await openDatabase(
      join(await getDatabasesPath(), 'weather.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE weather(city TEXT PRIMARY KEY, temperature TEXT, condition TEXT, date TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getAllWeatherData() async {
    final db = await database;
    return await db.query('weather');
  }

  Future<void> insertWeather(String city, String temperature, String condition, String date) async {
    final db = await database;
    await db.insert(
      'weather',
      {'city': city, 'temperature': temperature, 'condition': condition, 'date': date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getWeather(String city) async {
    final db = await database;
    return await db.query(
      'weather',
      where: 'city = ?',
      whereArgs: [city],
    );
  }

  Future<void> deleteWeather(String city) async {
    final db = await database;
    await db.delete('weather', where: 'city = ?', whereArgs: [city]);
  }
}
