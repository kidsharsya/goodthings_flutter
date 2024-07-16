import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/good_things_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(
        await getDatabasesPath(), 'new_goodthings.db'); // Nama database baru

    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE goodthings(id INTEGER PRIMARY KEY, userId TEXT, description TEXT, status TEXT, createdAt TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertGoodThing(GoodThing goodThing) async {
    final db = await database;
    try {
      await db.insert(
        'goodthings',
        goodThing.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting good thing: $e");
    }
  }

  Future<void> updateGoodThingStatus(GoodThing goodThing) async {
    final db = await database;
    await db.update(
      'goodthings',
      goodThing.toMap(),
      where: 'id = ?',
      whereArgs: [goodThing.id],
    );
  }

  Future<List<GoodThing>> getGoodThings(String userId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'goodthings',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC', // Urutkan berdasarkan createdAt
    );

    return List.generate(maps.length, (i) {
      return GoodThing(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        description: maps[i]['description'],
        status: maps[i]['status'],
        createdAt: DateTime.parse(maps[i]['createdAt']), // Ambil createdAt
      );
    });
  }

  Future<void> deleteGoodThing(int id) async {
    final db = await database;
    await db.delete(
      'goodthings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
