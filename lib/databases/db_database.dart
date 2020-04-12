import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class DB {
  static final DB _instance = new DB.internal();
  factory DB() => _instance;
  DB.internal();

  final String userTable = "userTable";
  final String colId = "id";
  final String colAddress = "address";
  final String productsList = "productsList";

  static Database _db;
  Future<Database> get db async { 
    // If _db exists in memory
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory directoryDoc = await getApplicationDocumentsDirectory();
    String path = join(directoryDoc.path, "db_user.db");

    var internalDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return internalDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY,"$colAddress" TEXT, $productsList TEXT)',
    );
  }

  Future<int> insertUser(User user) async {
    var dbClient = await db;

    int res = await dbClient.insert("$userTable", user.toMap());
    return res;
  }

  Future<List> getUsers() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $userTable");
    return res.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) from $userTable"));
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery("SELECT * FROM $userTable WHERE $colId = $id");
    if (res.length == 0) return null;
    return new User.fromMap(res.first);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(userTable, where: "$colId = ?", whereArgs: [id]);
  }

  Future<int> editUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(
      userTable,
      user.toMap(),
      where: "$colId = ?",
      whereArgs: [user.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
