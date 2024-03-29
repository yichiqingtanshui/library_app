import 'package:library_app/app/model/entity/borrower.dart';
import 'package:sqflite/sqflite.dart';

import 'package:library_app/app/model/dao/interface/common_dao.dart';
import 'package:library_app/app/model/entity/borrowing_info.dart';
import 'package:library_app/app/model/service/app_database.dart';
import 'package:library_app/app/model/entity/book.dart';

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

  Future<List<BorrowingInfo>> findByBook(Book book) async {
    Database db = await appDataBase.getWritableDb();

    List<Map<String, dynamic>> rawBorrowingInfos =
        await db.query(tableName, where: 'book_id = ?', whereArgs: [book.id]);
    List<BorrowingInfo> borrowingInfos =
        rawBorrowingInfos.map((info) => BorrowingInfo.fromMap(info)).toList();

    return borrowingInfos;
  }

  Future<List<BorrowingInfo>> findByBorrower(Borrower borrower) async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> results = await db
        .query(tableName, where: 'borrower_id = ?', whereArgs: [borrower.id]);
    List<BorrowingInfo> borrowingInfos =
        results.map((info) => BorrowingInfo.fromMap(info)).toList();
    return borrowingInfos;
  }

  Future<List<BorrowingInfo>> findByInfo(int borrowerId, int bookId) async {
    Database db = await appDataBase.getWritableDb();
    String sql = """
SELECT *
FROM borrowing_info
WHERE borrower_id = ?
  AND book_id = ?
    """;

    List<Map<String, dynamic>> rawBorrowingInfos =
        await db.rawQuery(sql, [borrowerId, bookId]);
    List<BorrowingInfo> borrowingInfos =
        rawBorrowingInfos.map((info) => BorrowingInfo.fromMap(info)).toList();
    return borrowingInfos;
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
