import 'package:sqflite/sqflite.dart';

import 'package:library_app/app/model/dao/interface/common_dao.dart';
import 'package:library_app/app/model/entity/borrowing_info.dart';
import 'package:library_app/app/model/service/app_database.dart';

class BorrowingInfoDao implements CommonDao<BorrowingInfo> {
  static const String tableName = 'borrowing_info';
  AppDataBase appDataBase = AppDataBase();

  @override
  Future<bool> add(BorrowingInfo borrowingInfo) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.insert(tableName, borrowingInfo.toMap());
    return result == 1;
  }

  @override
  Future<bool> addAll(List<BorrowingInfo> borrowingInfos) async {
    Database db = await appDataBase.getWritableDb();
    int result = 0;
    borrowingInfos.forEach((borrowingInfo) async {
      await db.insert(tableName, borrowingInfo.toMap());
      result++;
    });
    return result == borrowingInfos.length;
  }

  @override
  Future<BorrowingInfo> find(int id) async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> rawBorrowingInfo =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    BorrowingInfo info = BorrowingInfo.fromMap(rawBorrowingInfo[0]);
    return info;
  }

  @override
  Future<List<BorrowingInfo>> findAll() async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> rawBorrowingInfos = await db.query(tableName);
    List<BorrowingInfo> borrowers = rawBorrowingInfos
        .map((rawBorrowingInfo) => BorrowingInfo.fromMap(rawBorrowingInfo))
        .toList();
    return borrowers;
  }

  @override
  Future<bool> remove(int id) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return result == 1;
  }

  @override
  Future<bool> update(BorrowingInfo borrowingInfo) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.update(tableName, borrowingInfo.toMap(),
        where: 'id = ?', whereArgs: [borrowingInfo.id]);
    return result == 1;
  }
}
