import 'package:flutter/material.dart';

import 'app/model/entity/book.dart';
import 'app/controller/book_controller.dart';
import 'util/helper_log.dart';

void main() => runApp(LibraryApp());

class LibraryApp extends StatelessWidget {
  final BookController bookController = BookController();

  LibraryApp() {
    bookController
        .fetchAll()
        .then((_) => log(_.toString()))
        .whenComplete(() => log('1 fetchAll ok'));

//    Book updatedBook = Book(
//      id: 1,
//      press: ' ',
//      brief: ' ',
//      author: ' ',
//      amount: 3,
//      title: ' ',
//      isbn: 0,
//      publish_time: ' ',
//    );
//
//    bookController
//        .modifyInfoById(updatedBook)
//        .then((_) => log(_.toString()))
//        .whenComplete(() => log('1 modifyInfoById ok'));
////
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
