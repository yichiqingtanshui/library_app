import 'package:flutter/material.dart';

import 'app/controller/book_controller.dart';
import 'util/helper_log.dart';

void main() => runApp(LibraryApp());

class LibraryApp extends StatelessWidget {
  final BookController bookController = BookController();

  LibraryApp() {
    bookController
        .fetchAll()
        .then((_) => log(_.toString()))
        .whenComplete(() => log('fetchAll ok'));

//    bookController
//        .modifyInfoById(1, {'title': 'C++ Primer', 'isbn': 123123123})
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('modifyInfoById ok'));

//    bookController
//        .removeById(1)
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('removeById ok'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LibraryApp',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('图书馆管理系统'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('首页'),
        ),
      ),
    );
  }
}
