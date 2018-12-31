import 'dart:async';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



abstract class SimpleEntityDatabaseHelper<Entity> {

  @protected
  String tableName;
  @protected
  String columnId;
  @protected
  List<String> columns;


  @protected
  Entity entityFromMap(Map m);

  @protected
  Map<String, dynamic> entityToMap(Entity entity);

  @protected
  int getEntityId(Entity entity);

  @protected
  Entity mutateEntityId(Entity entity, int newId);

  @protected
  void onCreate(Database database, int version) ;


  Database _db;
  Future<Database> get db async {
    if (_db != null)
      return _db;
    else
      await _initDb();

    return _db;
  }

  Future _initDb() async {
    String myDbPath = await _getDbPath();
    _db = await openDatabase(myDbPath, version: 1, onCreate: onCreate);
  }

  Future<String> _getDbPath() async {
    String allDbPath = await getDatabasesPath();
    String myDbPath = join(allDbPath, '$tableName'+'.db');
    return myDbPath;
  }

  Future<Entity> insert(Entity entity) async {
    var dbInstance = await db;
    int newId = await dbInstance.insert(tableName, entityToMap(entity));
    return mutateEntityId(entity, newId);
  }

  Future<List<Entity>> getAllEntities() async {
    var dbInstance = await db;
    List<Map> entityMaps = await _queryAll(dbInstance);
    if (entityMaps.length > 0) {
      List<Entity> entities = entityMaps.map((entityMap) {
        return entityFromMap(entityMap);
      }).toList();
      return Future.value(entities);
    }
    return Future.value(List<Entity>());
  }

  Future<List<Map>> _queryAll(Database dbInstance) async {
    return dbInstance.query(tableName, columns: columns);
  }


  Future<Entity> getEntity(int id) async {
    var dbInstance = await db;
    List<Map> maps = await _queryById(dbInstance, id);
    if (maps.length > 0)
      return entityFromMap(maps.first);
    return null;
  }

  Future<List<Map>> _queryById(Database dbInstance, int id) {
    return dbInstance.query(tableName,
        columns: columns,
        where: '$columnId = ?',
        whereArgs: [id]);
  }


  Future<int> delete(int id) async {
    var dbInstance = await db;
    return await dbInstance.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var dbInstance = await db;
    return await dbInstance.delete(tableName, where: '1');
  }

  Future<int> update(Entity entity) async {
    var dbInstance = await db;
    return await dbInstance.update(tableName, entityToMap(entity),
        where: '$columnId = ?', whereArgs: [getEntityId(entity)]);
  }

  Future close() async {
    var dbInstance = await db;
    dbInstance.close();
  }
}