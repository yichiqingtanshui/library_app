import 'package:flutter/material.dart';
import 'package:library_app/app/controller/book_manager_controller.dart';
import 'package:library_app/app/controller/borrower_controller.dart';
import 'package:library_app/app/model/service/app_database.dart';
import 'package:library_app/util/helper_db_functions.dart';
import 'package:sqflite/sqflite.dart';

import 'app/model/entity/book.dart';
import 'app/controller/book_controller.dart';
import 'util/helper_log.dart';

void main() async => runApp(LibraryApp());

class LibraryApp extends StatelessWidget {
  LibraryApp() {
//    bookController
//        .fetchAll()
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('1 fetchAll ok'));
//
//    bookController
//        .modifyInfoById(updatedBook)
//        .then((_) => log(_.toString()))
//        .catchError((e) => log('出错 $e'))
//        .whenComplete(() => log('1 modifyInfoById ok'));
//
//    bookController
//        .fetchAll()
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('2 fetchAll ok'));
//
//    bookController
//        .removeById(1)
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('1 removeById ok'));
//
//    bookController
//        .fetchAll()
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('3 fetchAll ok'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LibraryApp',
      theme: ThemeData.light(),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  final BookController bookController = BookController();
  final BorrowerController borrowerController = BorrowerController();

  @override
  State<StatefulWidget> createState() =>
      AppState(bookController, borrowerController);
}

class AppState extends State<App> {
  BookController bookController;
  BorrowerController borrowerController;

//  BookManagerController bookManagerController;

  AppState(this.bookController, this.borrowerController);

  _testBookController() async {
    sqlfiteDebugOn(); // FIXME:记得再不需要debug时删除此语句
//    AppDataBase dbHelper = AppDataBase();
//    Database db = await dbHelper.getWritableDb();

    Book updatedBook = Book(
      id: 1,
      press: ' ',
      brief: ' ',
      author: ' ',
      amount: 3,
      title: ' ',
      isbn: 0,
      publish_time: ' ',
    );

    log((await bookController.fetchAll()).toString());
//    await bookController.modifyByBook(updatedBook);
//    log((await bookController.fetchAll()).toString());
  }

  _testBorrowerController() async {
    sqlfiteDebugOn(); // FIXME:记得再不需要debug时删除此语句
//    AppDataBase dbHelper = AppDataBase();
//    Database db = await dbHelper.getWritableDb();

    log((await borrowerController.fetchAll()).toString());
  }

//  _testBookManagerController() async {
//    sqlfiteDebugOn(); // FIXME:记得再不需要debug时删除此语句
////    AppDataBase dbHelper = AppDataBase();
////    Database db = await dbHelper.getWritableDb();
//
//    log((await bookManagerController.fetchAll()).toString());
//  }

  @override
  void initState() {
    super.initState();
    () async {
      await _testBookController();
      await _testBorrowerController();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图书馆管理系统'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('首页'),
      ),
    );
  }
}
