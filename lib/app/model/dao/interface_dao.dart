import 'dart:async';

import 'dart:typed_data' show Uint8List;

abstract class CommonDao<Model> {
  Future<bool> add(Model model);

  Future<bool> addAll(List<Model> models);

  Future<bool> remove(int id);

  Future<bool> update(Model model);

  Future<Model> find(int id);

  Future<List<Model>> findAll();
}
