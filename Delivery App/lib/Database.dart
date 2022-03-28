import 'package:delivery_app/models/orderitem.dart';
import 'package:delivery_app/models/restaurant.dart';
import 'package:delivery_app/models/shoppingcart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:delivery_app/models/user.dart';

import 'models/produs.dart';

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
            );

            CREATE TABLE produs (
              id_produs INTEGER PRIMARY KEY AUTOINCREMENT,
              NUME TEXT NOT NULL,
              DESCRIERE TEXT,
              PRET REAL NOT NULL,
            );

            CREATE TABLE shoppingcart (
              id_shopping INTEGER PRIMARY KEY AUTOINCREMENT,
              email TEXT NOT NULL,
              List<orderitems>, 
              FOREIGN KEY (email)
              REFERENCES user (email) 
                ON UPDATE SET NULL
                ON DELETE SET NULL
              FOREIGN KEY (orderitems)
              REFERENCES orderitem (id_order) 
              ON UPDATE SET NULL
              ON DELETE SET NULL
            );

           CREATE TABLE orderitem (
              id_order INTEGER PRIMARY KEY AUTOINCREMENT,
              id_produs INTEGER NOT NULL,
              id_shopping INTEGER NOT NULL,
              cantitate INTEGER DEFAULT 1, 
              FOREIGN KEY (id_produs)
              REFERENCES produs (id_produs) 
                ON UPDATE SET NULL
                ON DELETE SET NULL,
              FOREIGN KEY (id_shopping)
              REFERENCES shoppingcart (id_shopping) 
                ON UPDATE SET NULL
                ON DELETE SET NULL
            );

            CREATE TABLE restaurant (
              id_restaurant INTEGER PRIMARY KEY AUTOINCREMENT,
              nume TEXT NOT NULL,
              adresa TEXT NOT NULL,
              List<produs>, 
              FOREIGN KEY (produs)
              REFERENCES produs (id_produs) 
                ON UPDATE SET NULL
                ON DELETE SET NULL
              
            );



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


  newProdus(Produs newProdus) async {
    final db = await database;

    var res;
   res = await db.rawInsert('''
      INSERT INTO produs(
          nume, descriere, pret
        ) VALUES (?, ?, ?)
      ''', [
        newProdus.nume,
        newProdus.descriere,
        newProdus.pret,
      ]);
    return true;
  }

  newshoppingCart(ShoppingCart newshoppingCart) async {
    final db = await database;

    var res;
    res = await db.rawInsert('''
      INSERT INTO shoppingcart(
          user, produse
        ) VALUES (?, ?)
      ''', [
        newshoppingCart.user,
        newshoppingCart.produse,
      ]);
    return true;
  }

  neworderItem(OrderItem neworderItem) async {
    final db = await database;

    var res;
    res = await db.rawInsert('''
      INSERT INTO orderitem(
          produs, shoppingCart, cantitate
        ) VALUES (?, ?, ?)
      ''', [
        neworderItem.produs,
        neworderItem.shoppingCart,
        neworderItem.cantitate,
      ]);
    return true;
  }
  
  
  newRestaurant(Restaurant newRestaurant) async {
    final db = await database;

    var res;
    res = await db.rawInsert('''
      INSERT INTO restaurant(
          nume, adresa, produse_restaurant
        ) VALUES (?, ?, ?)
      ''', [
        newRestaurant.nume,
        newRestaurant.adresa,
        newRestaurant.produse_restaurant,
      ]);
    return true;
  }

  
  Future<Map<String, Object?>?> checkUser(email, password) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM users where email='$email' AND password='$password'");
    if (res.isEmpty) return null;
    return res[0];
  }

  Future<dynamic> getUsers() async {
    final db = await database;
    var res = await db.query("users");
    // print(res);
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}
