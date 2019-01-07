import 'ExerciseType.dart';

class ExerciseInstance {
  static const String TRAITS_SEPARATOR = '~';
  static const String ID_SEPARATOR = ':';

  ExerciseType exerciseType;

  int weight;
  Duration duration;
  int repetitions;
  int times;

  ExerciseInstance();

  String toString() {
    return exerciseType.id.toString() + ID_SEPARATOR
        + (exerciseType.hasWeight ? weight.toString() : '') + TRAITS_SEPARATOR
        + (exerciseType.hasDuration ? duration.inMilliseconds.toString() : '') + TRAITS_SEPARATOR
        + (exerciseType.hasRepetitions ? repetitions.toString() : '') + TRAITS_SEPARATOR
        + (exerciseType.hasTimes ? times.toString() : '');
  }

  static ExerciseInstance mutateTraitsFromString(ExerciseInstance instance, String exerciseInstanceStringed) {
    List<String> traits = _traitsFromString(exerciseInstanceStringed);
    instance.weight = (traits[0] == '' ? null : int.parse(traits[0]));
    instance.duration = (traits[1] == '' ? null : Duration(milliseconds: int.parse(traits[1])));
    instance.repetitions = (traits[2] == '' ? null : int.parse(traits[2]));
    instance.times = (traits[3] == '' ? null : int.parse(traits[3]));
    return instance;
  }

  static int idFromString(String exerciseInstanceString) {
    return int.parse(exerciseInstanceString.split(ID_SEPARATOR)[0]);
  }

  static List<String> _traitsFromString(String exerciseInstanceString) {
    return exerciseInstanceString
        .split(ID_SEPARATOR)[1]
        .split(TRAITS_SEPARATOR);
  }
}