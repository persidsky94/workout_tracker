import 'package:sqflite/sqflite.dart';

import 'SimpleEntityDatabaseHelper.dart';
import '../dataLayer/RawWorkoutInstance.dart';

class RawWorkoutInstanceDatabaseHelper extends SimpleEntityDatabaseHelper<RawWorkoutInstance> {
  static final RawWorkoutInstanceDatabaseHelper instance =
    new RawWorkoutInstanceDatabaseHelper._internal(
        workoutInstancesTableName, columnId, workoutInstanceColumns);

  factory RawWorkoutInstanceDatabaseHelper() => instance;

  RawWorkoutInstanceDatabaseHelper._internal(String tableName, String colId, List<String> columns) {
    this.tableName = tableName;
    this.columnId = colId;
    this.columns = columns;
  }

  @override
  RawWorkoutInstance entityFromMap(Map m) {
    return RawWorkoutInstance.fromMap(m);
  }

  @override
  Map<String, dynamic> entityToMap(RawWorkoutInstance entity) {
    return entity.toMap();
  }

  @override
  int getEntityId(RawWorkoutInstance entity) {
    return entity.id;
  }

  RawWorkoutInstance mutateEntityId(RawWorkoutInstance entity, int newId) {
    entity.id = newId;
    return entity;
  }

  void onCreate(Database database, int version) async {
    await database.execute(
      '''
      create table $workoutInstancesTableName (
        $columnId integer primary key autoincrement,
        $columnWorkoutTypeId integer not null,
        $columnDate integer not null
        $columnExerciseInstancesStrings text not null)
      '''
    );
  }
}