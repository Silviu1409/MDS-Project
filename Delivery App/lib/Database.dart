import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:delivery_app/models/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'delivery_app.db'),
        onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE users (
              email TEXT PRIMARY KEY, 
              password TEXT NOT NULL,
              username TEXT NOT NULL,
              phoneno TEXT NOT NULL,
              role TEXT NOT NULL
            )
          ''');
    }, version: 1);
  }

  newUser(User newUser) async {
    final db = await database;

    var res;
    try {
      res = await db.rawInsert('''
        INSERT INTO users(
          email, password, username, phoneno, role
        ) VALUES (?, ?, ?, ?, ?)
      ''', [
        newUser.email,
        newUser.password,
        newUser.username,
        newUser.phoneno,
        newUser.role,
      ]);
    } on Exception {
      print("e-mail address already exists");
      return false;
    }

    return true;
  }

  Future<bool> checkUser(email, password) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM users where email='$email' AND password='$password'");
    if (res.isEmpty) return false;
    return true;
  }

  Future<dynamic> getUsers() async {
    final db = await database;
    var res = await db.query("users");
    print(res);
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}
