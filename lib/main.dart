import 'package:flutter/material.dart';
import 'package:library_app/app/controller/book_manager_controller.dart';
import 'package:library_app/app/controller/borrower_controller.dart';
import 'package:library_app/app/model/service/app_database.dart';
import 'package:library_app/app/view/book_manager_page.dart';
import 'package:library_app/app/view/subpage/add_book_page.dart';
import 'package:library_app/app/view/subpage/add_borrower_page.dart';
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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        AddBookPage.routeName: (BuildContext context) => AddBookPage(),
        AddBorrowerPage.routeName: (BuildContext context) => AddBorrowerPage(),
      },
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
  int _selectedIndex = 0;
  final _widgetOptions = [
    BookManagerPage(),
    Text('Index 1: Business'),
    Text('Index 2: School'),
  ];

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
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
