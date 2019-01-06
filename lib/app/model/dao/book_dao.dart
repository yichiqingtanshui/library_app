import 'package:sqflite/sqflite.dart';

import 'package:library_app/app/model/service/app_database.dart';
import 'package:library_app/app/model/entity/book.dart' show Book;

import 'package:library_app/app/model/dao/interface/common_dao.dart';

class BookDao implements CommonDao<Book> {
  static const String tableName = 'book';
  AppDataBase appDataBase = AppDataBase();

  @override
  Future<bool> add(Book book) async {
    Database db = await appDataBase.getWritableDb();
    int result = await db.insert(tableName, book.toMap());
//    await db.close();
    return result == 1;
  }

  @override
  Future<bool> addAll(List<Book> books) async {
    Database db = await appDataBase.getWritableDb();
    int result = 0;

    books.map((book) async {
      await db.insert(tableName, book.toMap());
      result++;
    });

//    await db.close();
    return result != books.length;
  }

  @override
  Future<Book> find(int id) async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> rawBooks =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);

//    await db.close();

    return Book.fromMap(rawBooks[0]);
  }

  @override
  Future<List<Book>> findAll() async {
    Database db = await appDataBase.getWritableDb();
    List<Map<String, dynamic>> rawBooks = await db.query(tableName);

    List<Book> books = rawBooks.map((book) => Book.fromMap(book)).toList();

    //    await db.close();

    return books;
  }

  @override
  Future<bool> remove(int id) async {
    Database db = await appDataBase.getWritableDb();

    int result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);

//    await db.close();

    return result == 1;
  }

  @override
  Future<bool> update(Book book) async {
    Database db = await appDataBase.getWritableDb();

    int result = await db
        .update(tableName, book.toMap(), where: 'id = ?', whereArgs: [book.id]);

//    await db.close();

    return result == 1;
  }
}
