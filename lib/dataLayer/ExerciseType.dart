
final String exerciseTypesTableName = 'exerciseTypes';
final String columnId               = '_id';
final String columnName             = 'exerciseName';
final String columnWeight           = 'exerciseWeight';
final String columnDuration         = 'exerciseDuration';
final String columnRepetitions      = 'exerciseRepetition';
final String columnTimes            = 'exerciseTimes';
final List<String> exerciseColumns  = [columnId, columnName, columnWeight, columnDuration, columnRepetitions, columnTimes];

class ExerciseType {
  int id;
  String name;
  bool hasWeight;
  bool hasDuration;
  bool hasRepetitions;
  bool hasTimes;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnWeight: hasWeight == true ? 1 : 0,
      columnDuration: hasDuration == true ? 1 : 0,
      columnRepetitions: hasRepetitions == true ? 1 : 0,
      columnTimes : hasTimes == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  ExerciseType();

  ExerciseType.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    hasWeight = map[columnWeight] == 1;
    hasDuration = map[columnDuration] == 1;
    hasRepetitions = map[columnRepetitions] == 1;
    hasTimes = map[columnTimes] == 1;
  }
}