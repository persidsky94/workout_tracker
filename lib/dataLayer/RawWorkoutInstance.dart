

final String workoutInstancesTableName  = 'workoutInstances';
final String columnId = '_id';
final String columnWorkoutTypeId = 'workoutTypeId';
final String columnDate = 'workoutDate';
final String columnExerciseInstancesStrings = 'exerciseInstancesStrings';
final List<String> workoutInstanceColumns =
  [columnId, columnWorkoutTypeId, columnDate, columnExerciseInstancesStrings];


class RawWorkoutInstance {
  int id;
  int workoutTypeId;
  DateTime workoutDate;
  List<String> exerciseInstancesStrings;

  RawWorkoutInstance();


  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnWorkoutTypeId: workoutTypeId,
      columnDate: workoutDate.millisecondsSinceEpoch,
      columnExerciseInstancesStrings: _exerciseInstancesStringsToCommaSeparatedString(exerciseInstancesStrings),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  RawWorkoutInstance.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    workoutTypeId = map[columnWorkoutTypeId];
    workoutDate = DateTime.fromMillisecondsSinceEpoch(map[columnDate]);
    exerciseInstancesStrings = _commaSeparatedStringToExerciseInstances(map[columnExerciseInstancesStrings]);
  }

  String _exerciseInstancesStringsToCommaSeparatedString(List<String> exerciseInstances) {
    return exerciseInstances.reduce((value, element) => value + ',' + element);
  }

  List<String> _commaSeparatedStringToExerciseInstances(String commaSeparatedString) {
    List<String> exerciseInstances = commaSeparatedString.split(',');
    exerciseInstances.remove('');
    if (exerciseInstances.length == 0)
      return List<String>();
    return exerciseInstances;
  }
}