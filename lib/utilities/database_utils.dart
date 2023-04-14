import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../bloc/email/email.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tasks_db.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE email ("
          "transaction_id TEXT PRIMARY KEY,"
          "transaction_desc TEXT,"
          "transaction_status TEXT,"
          "transaction_datetime TEXT,"
          ")");
    });
  }

  newEmail(Email cart) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into email (transaction_id,transaction_desc,transaction_status,transaction_datetime)"
        " VALUES (?,?,?,?)",
        [
          cart.transactionId,
          cart.transactionDesc,
          cart.transactionStatus,
          cart.transactionDatetime,
        ]);
    return raw;
  }

  updateEmail(Email cart) async {
    final db = await database;
    // var res = await db.update("carts", {"qty": cart!.qty},
    //     where: 'id = ?', whereArgs: [cart.id]);
    // return res;
  }

  getEmail(String id) async {
    final db = await database;
    var res = await db.query("email", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Email.fromJson(res.first) : null;
  }

  Future<List<Email>> getAllEmail() async {
    final db = await database;
    var res = await db.query("email");
    List<Email> list =
        res.isNotEmpty ? res.map((c) => Email.fromJson(c)).toList() : [];
    return list;
  }

  deleteEmail(String id) async {
    final db = await database;
    return db.delete("email", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    return db.delete("email");
  }
}
