import 'package:sqflite/sqflite.dart';

import 'package:library_app/app/model/entity/borrower.dart';
import 'package:library_app/app/model/dao/interface/common_dao.dart'
    show CommonDao;
import 'package:library_app/app/model/service/app_database.dart';

class BorrowerDao implements CommonDao<Borrower> {
  static const String tableName = 'borrower';
  AppDataBase appDataBase = AppDataBase();

  @override
  Future<bool> add(Borrower borrower) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.insert(tableName, borrower.toMap());
    return result == 1;
  }

  @override
  Future<bool> addAll(List<Borrower> borrowers) async {
    Database db = await appDataBase.getWritableDb();
    int result = 0;
    borrowers.forEach((borrower) async {
      await db.insert(tableName, borrower.toMap());
      result++;
    });
    return result == borrowers.length;
  }

  @override
  Future<bool> remove(int id) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return result == 1;
  }

  @override
  Future<bool> update(Borrower borrower) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.update(tableName, borrower.toMap(),
        where: 'id = ?', whereArgs: [borrower.id]);
    return result == 1;
  }

  @override
  Future<Borrower> find(int id) async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> rawBorrowers =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    Borrower borrower = Borrower.fromMap(rawBorrowers[0]);
    return borrower;
  }

  @override
  Future<List<Borrower>> findAll() async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> rawBorrowers = await db.query(tableName);
    List<Borrower> borrowers = rawBorrowers
        .map((rawBorrower) => Borrower.fromMap(rawBorrower))
        .toList();
    return borrowers;
  }

}
