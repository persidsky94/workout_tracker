import 'ExerciseType.dart';
import 'RawWorkoutType.dart';

class WorkoutType {
  int id;
  String name;
  List<ExerciseType> exerciseTypes;

  RawWorkoutType toRaw() {
    RawWorkoutType rawWorkoutType = RawWorkoutType();
    rawWorkoutType.id = this.id;
    rawWorkoutType.name = this.name;
    rawWorkoutType.exerciseTypeIds = exerciseTypes.map((exersiceType) => exersiceType.id).toList();
    return rawWorkoutType;
  }

}