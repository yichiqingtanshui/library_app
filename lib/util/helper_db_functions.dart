import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'helper_log.dart' show log;

/// **开启flutter_sqflite.debug模式**
/// - A quick way to view SQL commands printed out is to call before opening any database
/// - **注意**: 在调用任何打开数据库***之前***调用
/// - 参考: [Debugging SQL commands](https://github.com/tekartik/sqflite/blob/master/doc/troubleshooting.md#debugging-sql-commands)
void sqlfiteDebugOn() async {
  await Sqflite.devSetDebugModeOn(true);
}

/// **获取指定 db name 的路径**
Future<String> getTargetDBPath(String dbName) async {
  var databasesPath = await getDatabasesPath();
  log(databasesPath);

  var path = join(databasesPath, dbName);

  print('[INFO] 数据库放在: $path');

  // 确保创建目录
  try {
    await Directory(databasesPath).create(recursive: true);
  } catch (_) {}
  return path;
}

/// **导入指定数据库**
/// - 第一次启动App将从指定数据库复制副本到AppData处,
/// 若APPData已存在修改过的数据库,则使用该数据库,
/// 这可以提高性能.
/// - **注意**:使用该函数,避免直接或间接的引用多个相同数据库实例,以保持单数据库引用,避免死锁竞争,
/// > 参考 :[Optimizing for performance](https://github.com/tekartik/sqflite/blob/master/doc/opening_asset_db.md#optimizing-for-performance)
Future<Database> openAndImportExistingSQLiteFile(String assetDBName) async {
  String path = await getTargetDBPath(assetDBName);
  Database db;

  try {
    db = await openDatabase(path);
  } catch (e) {
    log("错误 $e");
  }

  if (db == null) {
    log("将从asset中的db复制新的副本");

    // 复制该数据库
    ByteData data = await rootBundle.load(join("assets", assetDBName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);

    // open the database
    db = await openDatabase(path);
  } else {
    log("打开已存数据库");
  }

  return db;
}

/// **防止数据库的辅助类**
/// - 内部使用lock()来确保数据库只打开一次
class DBHelper {
  final String dbName;

  DBHelper(this.dbName);

  Database _db;
  final _lock = Lock();

  /// **获取数据库单例**
  Future<Database> getDb() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        // Check again once entering the synchronized block
        if (_db == null) {
//					_db = await openDatabase(path);
          _db = await openAndImportExistingSQLiteFile(dbName);
        }
      });
    }
    return _db;
  }
}
