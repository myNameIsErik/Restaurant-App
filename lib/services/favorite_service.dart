import 'package:restaurant_app/data/model/favorite_restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteService {
  static Database? _database;
  static const String _tableName = 'favorites';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'restaurant.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            city TEXT,
            address TEXT,
            pictureId TEXT,
            rating REAL
          )
        """);
      },
    );
  }

  Future<int> insertFavorite(FavoriteRestaurant restaurant) async {
    final db = await database;
    return await db.insert(_tableName, restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FavoriteRestaurant>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(
        maps.length, (i) => FavoriteRestaurant.fromMap(maps[i]));
  }

  Future<int> deleteFavorite(String id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
