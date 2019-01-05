// skip this file to avoid getting errors when running your unit tests
@Skip("sqflite cannot run on the machine.")

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLitePathsDao {
  SQLitePathsDao(Object sqlite);
}

class SQLite {
  final Database db;

  final String path;

  SQLite({this.db, this.path});

  setup() {}
}

const String testDBPath = "somepath";
SQLitePathsDao dao;
SQLite sqlite;

void main() {
  group("SQLiteDao tests", () {
    setUp(() async {
      sqlite = SQLite(path: (await getDatabasesPath()) + "/" + testDBPath);

      await sqlite.setup();
      dao = SQLitePathsDao(sqlite);
    });

    // Delete the database so every test run starts with a fresh database
    tearDownAll(() async {
      await deleteDatabase((await getDatabasesPath()) + "/" + testDBPath);
    });

    test("should insert and query path by id", () async {
      // Path p = Path(name: "my path", isArriveAt: true, time: DateTime.now());
      // p = await dao.insertPath(p);
      // expect(p.id, isNotNull);

      // var qp = await dao.getPath(p.id);

      // expect(qp.name, p.name);
      // expect(qp.isArriveAt, p.isArriveAt);
      // expect(qp.id, p.id);
    });

    test("sample sqflite test code", () async {
      var result = await sqlite.db
          .query('sampleTableName', where: "id = ?", whereArgs: ['123']);
      expect(result.length, 0);
    });
  });
}
