import 'package:flutter/material.dart';
import 'package:library_app/app/controller/borrower_controller.dart';
import 'package:library_app/app/view/book_manager_page.dart';
import 'package:library_app/app/view/borrower_manager_page.dart';
import 'package:library_app/app/view/subpage/book_details_page.dart';
import 'package:library_app/app/view/subpage/borrower_details_page.dart';
import 'package:library_app/util/helper_db_functions.dart';

import 'util/helper_log.dart';

void main() async => runApp(LibraryApp());

class LibraryApp extends StatelessWidget {
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
  final BorrowerController bookController = BorrowerController();
  final BorrowerController borrowerController = BorrowerController();

  @override
  State<StatefulWidget> createState() =>
      AppState(bookController, borrowerController);
}

class AppState extends State<App> {
  BorrowerController bookController;
  BorrowerController borrowerController;
  int _selectedIndex = 0;
  final _widgetOptions = [
    BookManagerPage(),
    BorrowerManagerPage(),
    Text('Index 2: School'),
  ];

  AppState(this.bookController, this.borrowerController);

  _testBookController() async {
    sqlfiteDebugOn(); // FIXME:记得再不需要debug时删除此语句

    log((await bookController.fetchAll()).toString());
//    await bookController.modifyByBook(updatedBook);
//    log((await bookController.fetchAll()).toString());
  }

  _testBorrowerController() async {
    sqlfiteDebugOn(); // FIXME:记得再不需要debug时删除此语句

    log((await borrowerController.fetchAll()).toString());
  }

  @override
  void initState() {
    super.initState();
    () async {
      await _testBookController();
      await _testBorrowerController();
    }();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            icon: Icon(Icons.book),
            title: Text('图书管理'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('借阅人管理'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('借阅/还书'),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
