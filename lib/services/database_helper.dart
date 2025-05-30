import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:application_laboratorio/entity/activity.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> initializeDatabase() async {
    await database;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'activity.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activity (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertActivity(Activity activity) async {
    final db = await database;
    return await db.insert('activity', activity.toMap());
  }

  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activity');
    return List.generate(maps.length, (i) {
      return Activity.fromMap(maps[i]);
    });
  }

  Future<int> updateActivity(Activity activity) async {
    final db = await database;
    return await db.update(
      'activity',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  Future<int> deleteActivity(int id) async {
    final db = await database;
    return await db.delete(
      'activity',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
