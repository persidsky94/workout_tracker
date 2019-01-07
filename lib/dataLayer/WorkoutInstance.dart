import 'RawWorkoutInstance.dart';
import 'WorkoutType.dart';
import 'ExerciseInstance.dart';

class WorkoutInstance {
  int id;
  WorkoutType workoutType;
  DateTime workoutDate;
  List<ExerciseInstance> exerciseInstances;

  RawWorkoutInstance toRaw() {
    RawWorkoutInstance rawWorkoutInstance = RawWorkoutInstance()
        ..id = id
        ..workoutTypeId = workoutType.id
        ..workoutDate = workoutDate
        ..exerciseInstancesStrings = exerciseInstances.map((ei) => ei.toString()).toList();
    return rawWorkoutInstance;
  }

}