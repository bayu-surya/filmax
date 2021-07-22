import 'package:filmax/consumerprovider/data/model/tidakdigunakan/favorite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database!;
  }

  static const String _tblRestaurant = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblRestaurant (
                 id TEXT PRIMARY KEY,
                 name TEXT,
                 description TEXT,
                 picture_id TEXT,
                 city TEXT,
                 rating TEXT
               ) 
            ''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavorite(Favorite article) async {
    final db = await database;
    await db.insert(_tblRestaurant, article.toJson());
  }

  Future<List<Favorite>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblRestaurant);
    return results.map((res) => Favorite.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}