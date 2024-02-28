import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'demo.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets/database', 'demo.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }
//Insert=============================================================================
  Future<int> insertRecordIntoTbl_User(
      String name, String phone, String age) async {
    Database db = await initDatabase();
    Map<String, dynamic> map = {
      'Name': name,
      'Phone': phone,
      'Age': age,
    };
    int userId = await db.insert('Tbl_User', map);
    return userId;
  }
  //Update===============================================
Future<int> updateUser(userId,name,phone,age) async {
    Database db = await initDatabase();
    Map<String, dynamic> map = {
      'Name': name,
      'Phone': phone,
      'Age': age,
    };
    return await db.update('Tbl_User', map,where: 'UserId = ?',whereArgs: [userId]);
}
//GetAll=======================================================================
  Future<List<Map<String, dynamic>>> getUserListFromTbl_User() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userList =
        await db.rawQuery('SELECT * FROM Tbl_User');
    return userList;
  }
  //Delete==========================================================
  Future<void> deleteuser(userId) async {
    Database db = await initDatabase();
    await db.delete('Tbl_User',where: 'UserId = ?',whereArgs: [userId]);
  }
}
