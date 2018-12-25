import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../dataLayer/ExerciseType.dart';


class ExerciseTypeDatabaseHelper {
  static final ExerciseTypeDatabaseHelper instance = new ExerciseTypeDatabaseHelper._internal();
  factory ExerciseTypeDatabaseHelper() => instance;

  ExerciseTypeDatabaseHelper._internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null)
      return _db;
    else
      await _initDb();

    return _db;
  }

  Future _initDb() async {
    String myDbPath = await _getDbPath();
    _db = await openDatabase(myDbPath, version: 1, onCreate: _onCreate);
  }

  Future<String> _getDbPath() async {
    String allDbPath = await getDatabasesPath();
    String myDbPath = join(allDbPath, 'exercise_types.db');
    return myDbPath;
  }

  void _onCreate(Database database, int version) async {
    await database.execute(
        '''
      create table $tableExerciseTypes (
        $columnId integer primary key autoincrement,
        $columnName text not null,
        $columnWeight integer not null,
        $columnDuration integer not null,
        $columnRepetitions integer not null,
        $columnTimes integer not null)
      '''
    );
  }

  Future<ExerciseType> insert(ExerciseType exerciseType) async {
    var dbInstance = await db;
    exerciseType.id = await dbInstance.insert(tableExerciseTypes, exerciseType.toMap());
    return exerciseType;
  }

  Future<List<ExerciseType>> getAllExerciseTypes() async {
    var dbInstance = await db;
    List<Map> maps = await dbInstance.query(tableExerciseTypes,
        columns: [columnId, columnName, columnWeight, columnDuration, columnRepetitions, columnTimes]);
    if (maps.length > 0) {
      List<ExerciseType> exTypes = maps.map((et) {
        return ExerciseType.fromMap(et);
      }).toList();
      return Future.value(exTypes);
    }
    return Future.value(List<ExerciseType>());
  }

  Future<ExerciseType> getExerciseType(int id) async {
    var dbInstance = await db;
    List<Map> maps = await dbInstance.query(tableExerciseTypes,
        columns: [columnId, columnName, columnWeight, columnDuration, columnRepetitions, columnTimes],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ExerciseType.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    var dbInstance = await db;
    return await dbInstance.delete(tableExerciseTypes, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(ExerciseType exerciseType) async {
    var dbInstance = await db;
    return await dbInstance.update(tableExerciseTypes, exerciseType.toMap(),
        where: '$columnId = ?', whereArgs: [exerciseType.id]);
  }

  Future close() async {
    var dbInstance = await db;
    dbInstance.close();
  }
}