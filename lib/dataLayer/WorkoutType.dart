
final String workoutTypesTableName  = 'workoutTypes';
final String columnId               = '_id';
final String columnName             = 'workoutName';
final String columnExerciseTypeIds  = 'exerciseIds';
final List<String> workoutColumns = [columnId, columnName, columnExerciseTypeIds];


class WorkoutType {
  int id;
  String name;
  List<int> exerciseTypeIds;

  Map<String, dynamic> toMap() {
    //List<int> exerciseTypeIds = exerciseTypes.map((et) => et.id).toList();
    var map = <String, dynamic>{
      columnName: name,
      columnExerciseTypeIds: _idsToCommaSeparatedString(exerciseTypeIds),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  String _idsToCommaSeparatedString(List<int> ids) {
    String res ='';
    for(int i=0; i<ids.length; ++i) {
      int id = ids[i];
      res = res + '$id' + ',';
    }
    return res;
  }

  WorkoutType();

  WorkoutType.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    exerciseTypeIds = map[columnExerciseTypeIds];
  }
}