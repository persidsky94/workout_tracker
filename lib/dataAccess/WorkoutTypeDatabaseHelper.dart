import 'package:sqflite/sqflite.dart';

import 'SimpleEntityDatabaseHelper.dart';
import '../dataLayer/WorkoutType.dart';


class WorkoutTypeDatabaseHelper extends SimpleEntityDatabaseHelper<WorkoutType> {
  static final WorkoutTypeDatabaseHelper instance = new WorkoutTypeDatabaseHelper._internal(workoutTypesTableName, columnId, workoutColumns);
  factory WorkoutTypeDatabaseHelper() => instance;

  WorkoutTypeDatabaseHelper._internal(String tableName, String colId, List<String> columns) {
    this.tableName = tableName;
    this.columnId = colId;
    this.columns = columns;
  }

  WorkoutType entityFromMap(Map m) {
    return WorkoutType.fromMap(m);
  }

  Map<String, dynamic> entityToMap(WorkoutType entity) {
    return entity.toMap();
  }

  int getEntityId(WorkoutType entity) {
    return entity.id;
  }

  WorkoutType mutateEntityId(WorkoutType entity, int newId) {
    entity.id = newId;
    return entity;
  }

  void onCreate(Database database, int version) async {
    await database.execute(
        '''
      create table $workoutTypesTableName (
        $columnId integer primary key autoincrement,
        $columnName text not null,
        $columnExerciseTypeIds text not null
      '''
    );
  }

}