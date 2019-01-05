import 'dart:async';

import 'dart:typed_data' show Uint8List;

typedef int SQLiteTypesINTEGER();
typedef num SQLiteTypesREAL();
typedef String SQLiteTypesTEXT();
typedef Uint8List SQLiteTypesBLOB();

abstract class CommonDao<Model> {
	Future<bool> add(Model model);

	Future<bool> addAll(List<Model> models)

	Future<bool> remove(SQLiteTypesINTEGER id);

	Future<bool> update(Model model);

	Future<Model> find(SQLiteTypesINTEGER id);

	Future<List<Model>> findAll();
}
