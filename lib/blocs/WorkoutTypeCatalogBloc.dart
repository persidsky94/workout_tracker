import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';
import 'ExerciseTypeCatalogBloc.dart';
import 'RawWorkoutTypeCatalogBloc.dart';
import '../dataLayer/ExerciseType.dart';
import '../dataLayer/RawWorkoutType.dart';
import '../dataLayer/WorkoutType.dart';


class WorkoutTypeCatalogBloc extends BlocBase {

  final ExerciseTypeCatalogBloc _exerciseTypeCatalogBloc;
  final RawWorkoutTypeCatalogBloc _rawWorkoutTypeCatalogBloc;
  List<ExerciseType> _currentExerciseTypes = List<ExerciseType>();
  List<RawWorkoutType> _currentRawWorkoutTypes = List<RawWorkoutType>();
  bool _rawWorkoutTypesReady = false;
  bool _exerciseTypesReady = false;


  BehaviorSubject<List<WorkoutType>> _workoutTypesList = new BehaviorSubject();
  get _in_workoutTypesList => _workoutTypesList.sink;
  get out_workoutTypesList => _workoutTypesList.stream;

  BehaviorSubject<WorkoutType> _addWorkoutType = new BehaviorSubject();
  get in_addWorkoutType => _addWorkoutType.sink;

  BehaviorSubject<void> _removeAllWorkoutTypes = new BehaviorSubject();
  get in_removeAllWorkoutTypes => _removeAllWorkoutTypes.sink;


  WorkoutTypeCatalogBloc(this._exerciseTypeCatalogBloc, this._rawWorkoutTypeCatalogBloc) {
    _addWorkoutType.listen(_handle_addWorkoutType);
    _removeAllWorkoutTypes.listen(_handle_removeAllWorkoutTypes);

    _exerciseTypeCatalogBloc.out_rawEntitiesList.listen((list) {
      _currentExerciseTypes = list;
      _exerciseTypesReady = true;
      if (_readyToMatch())
        _matchRawWorkoutTypesWithExerciseTypes();
    });

    _rawWorkoutTypeCatalogBloc.out_rawEntitiesList.listen((list) {
      _currentRawWorkoutTypes = list;
      _rawWorkoutTypesReady = true;
      if (_readyToMatch())
        _matchRawWorkoutTypesWithExerciseTypes();
    });
  }

  bool _readyToMatch() {
    return _rawWorkoutTypesReady && _exerciseTypesReady;
  }

  void _matchRawWorkoutTypesWithExerciseTypes() {
    List<WorkoutType> workoutTypesList = _currentRawWorkoutTypes.map((rawWorkoutType) {
      WorkoutType workoutType = WorkoutType();
      workoutType.id = rawWorkoutType.id;
      workoutType.name = rawWorkoutType.name;
      workoutType.exerciseTypes = rawWorkoutType.exerciseTypeIds.map((exerciseTypeId) {
        return _currentExerciseTypes
            .where((exerciseType) => exerciseType.id == exerciseTypeId)
            .toList()
            .first;
        }).toList();
      return workoutType;
    }).toList();
    _in_workoutTypesList.add(workoutTypesList);
  }


  void _handle_addWorkoutType(WorkoutType workoutType) {
    _rawWorkoutTypeCatalogBloc.in_addRawEntity.add(workoutType.toRaw());
  }

  void _handle_removeAllWorkoutTypes(void _) {
    _rawWorkoutTypeCatalogBloc.in_removeAllRawEntities.add(_);
  }


  void dispose() {
    _addWorkoutType.close();
    _removeAllWorkoutTypes.close();
    _workoutTypesList.close();
  }
}