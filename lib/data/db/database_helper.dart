import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tblFav = 'favorites';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/myrestaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFav (
             id TEXT PRIMARY KEY,
             name TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    var json = restaurant.toJson();
    var dbValues = {
      'id': json['id'],
      'name': json['name'],
      'pictureId': json['pictureId'],
      'city': json['city'],
      'rating': json['rating'],
    };
    await db!.insert(_tblFav, dbValues);
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFav);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFav,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tblFav,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
