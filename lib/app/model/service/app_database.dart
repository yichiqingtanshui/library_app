import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:library_app/util/helper_log.dart';
import 'package:library_app/util/helper_db_functions.dart' show getTargetDBPath;

class AppDataBase {
  Database _db;
  final String dbName;
  bool readOnly;

  AppDataBase({
    @required this.dbName,
    this.readOnly = false,
  });

  ///
  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  _onCreate(Database db, int version) async {
    // 创建表
    await db.execute(createTabelSQL);
    // 填充数据
    await db.rawInsert(mockedInsertSQL);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 数据库版本升级后执行
    //		await db.execute();
  }

  _onOpen(Database db) async {
    // 数据库打开时调用
    log('数据库已打开 版本:${await db.getVersion()}');
  }

  Future<Database> getInstance() async {
    String path = await getTargetDBPath(dbName);

    if (_db == null) {
      if (readOnly) {
        _db = await openDatabase(
          path,
          version: 1,
          onCreate: _onCreate,
          onOpen: _onOpen,
          readOnly: true,
        );
      } else {
        _db = await openDatabase(
          path,
          version: 1,
          onCreate: _onCreate,
          onOpen: _onOpen,
        );
      }
    }
    return _db;
  }
}

const String createTabelSQL = """
  create table book
(
  id           INTEGER not null
    constraint book_pk
      primary key autoincrement,
  isbn         INTEGER,
  title        TEXT,
  press        TEXT,
  author       TEXT,
  brief        TEXT,
  amount       INTEGER,
  publish_time TEXT
);

create unique index book_isbn_uindex
  on book (isbn);
  """;

const String mockedInsertSQL = """
INSERT INTO book (id, isbn, title, press, author, brief, amount, publish_time) VALUES (1, 9787115439789, '第一行代码：Android(第2版)', '人民邮电出版社', '郭霖', '本书被广大Android 开发者誉为“Android 学习第一书”。全书系统全面、循序渐进地介绍了Android软件开发的必备知识、经验和技巧。

第2版基于Android 7.0 对第1 版进行了全面更新，将所有知识点都在最新的Android 系统上进行重新适配，使用 全新的Android Studio 开发工具代替之前的Eclipse，并添加了对Material Design、运行时权限、Gradle、RecyclerView、百分比布局、OkHttp、Lambda 表达式等全新知识点的详细讲解。

本书内容通俗易懂，由浅入深，既是Android 初学者的入门必备，也是Android 开发者的进阶首选。', 3, '2016-12-1');
INSERT INTO book (id, isbn, title, press, author, brief, amount, publish_time) VALUES (2, 9787121192821, 'Linux多线程服务端编程', '电子工业出版社', '陈硕', '本书主要讲述采用现代C++ 在x86-64 Linux 上编写多线程TCP 网络服务程序的主流常规技术，重点讲解一种适应性较强的多线程服务器的编程模型，即one loop per thread。这是在Linux 下以native 语言编写用户态高性能网络程序最成熟的模式，掌握之后可顺利地开发各类常见的服务端网络应用程序。本书以muduo 网络库为例，讲解这种编程模型的使用方法及注意事项。

本书的宗旨是贵精不贵多。掌握两种基本的同步原语就可以满足各种多线程同步的功能需求，还能写出更易用的同步设施。掌握一种进程间通信方式和一种多线程网络编程模型就足以应对日常开发任务，编写运行于公司内网环境的分布式服务统。', 3, '2013-1-15');
""";
