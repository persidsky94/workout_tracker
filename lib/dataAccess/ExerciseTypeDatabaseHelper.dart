
import 'package:sqflite/sqflite.dart';

import 'SimpleEntityDatabaseHelper.dart';
import '../dataLayer/ExerciseType.dart';


class ExerciseTypeDatabaseHelper extends SimpleEntityDatabaseHelper<ExerciseType> {
  static final ExerciseTypeDatabaseHelper instance = new ExerciseTypeDatabaseHelper._internal(exerciseTypesTableName, columnId, exerciseColumns);
  factory ExerciseTypeDatabaseHelper() => instance;

  ExerciseTypeDatabaseHelper._internal(String tableName, String columnId, List<String> columns) {
    this.tableName = tableName;
    this.columnId = columnId;
    this. columns = columns;
  }

  ExerciseType entityFromMap(Map m) {
    return ExerciseType.fromMap(m);
  }

  Map<String, dynamic> entityToMap(ExerciseType entity) {
    return entity.toMap();
  }

  int getEntityId(ExerciseType entity) {
    return entity.id;
  }

  ExerciseType mutateEntityId(ExerciseType entity, int newId) {
    entity.id = newId;
    return entity;
  }

  void onCreate(Database database, int version) async {
    await database.execute(
        '''
      create table $exerciseTypesTableName (
        $columnId integer primary key autoincrement,
        $columnName text not null,
        $columnWeight integer not null,
        $columnDuration integer not null,
        $columnRepetitions integer not null,
        $columnTimes integer not null)
      '''
    );
  }

}