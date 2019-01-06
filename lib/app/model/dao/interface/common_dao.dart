import 'dart:async';

abstract class CommonDao<Entity> {
  Future<bool> add(Entity e);

  Future<bool> addAll(List<Entity> e);

  Future<bool> remove(int id);

  Future<bool> update(Entity model);

  Future<Entity> find(int id);

  Future<List<Entity>> findAll();
}
