import 'package:sqflite/sqflite.dart';

import 'SimpleEntityDatabaseHelper.dart';
import '../dataLayer/RawWorkoutType.dart';


class RawWorkoutTypeDatabaseHelper extends SimpleEntityDatabaseHelper<RawWorkoutType> {
  static final RawWorkoutTypeDatabaseHelper instance = new RawWorkoutTypeDatabaseHelper._internal(workoutTypesTableName, columnId, workoutColumns);
  factory RawWorkoutTypeDatabaseHelper() => instance;


  RawWorkoutTypeDatabaseHelper._internal(String tableName, String colId, List<String> columns) {
    this.tableName = tableName;
    this.columnId = colId;
    this.columns = columns;
  }

  RawWorkoutType entityFromMap(Map m) {
    return RawWorkoutType.fromMap(m);
  }

  Map<String, dynamic> entityToMap(RawWorkoutType entity) {
    return entity.toMap();
  }

  int getEntityId(RawWorkoutType entity) {
    return entity.id;
  }

  RawWorkoutType mutateEntityId(RawWorkoutType entity, int newId) {
    entity.id = newId;
    return entity;
  }

  void onCreate(Database database, int version) async {
    await database.execute(
        '''
      create table $workoutTypesTableName (
        $columnId integer primary key autoincrement,
        $columnName text not null,
        $columnExerciseTypeIds text not null)
      '''
    );
  }

}