import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';
import 'ExerciseTypeCatalogBloc.dart';
import 'RawWorkoutInstanceCatalogBloc.dart';
import 'WorkoutTypeCatalogBloc.dart';
import '../dataLayer/ExerciseType.dart';
import '../dataLayer/ExerciseInstance.dart';
import '../dataLayer/RawWorkoutInstance.dart';
import '../dataLayer/WorkoutInstance.dart';
import '../dataLayer/WorkoutType.dart';


class WorkoutInstanceCatalogBloc extends BlocBase {

  RawWorkoutInstanceCatalogBloc rawWorkoutInstanceCatalogBloc;
  WorkoutTypeCatalogBloc workoutTypeCatalogBloc;
  ExerciseTypeCatalogBloc exerciseTypeCatalogBloc;
  List<RawWorkoutInstance> _currentRawWorkoutInstances = List();
  List<WorkoutType> _currentWorkoutTypes = List();
  List<ExerciseType> _currentExerciseTypes = List();
  bool _rawWorkoutInstancesReady = false;
  bool _workoutTypesReady = false;
  bool _exerciseTypesReady = false;


  BehaviorSubject<List<WorkoutInstance>> _workoutInstancesList = new BehaviorSubject();
  get _in_workoutInstancesList => _workoutInstancesList.sink;
  get out_workoutInstancesList => _workoutInstancesList.stream;

  BehaviorSubject<WorkoutInstance> _addWorkoutInstance = new BehaviorSubject();
  get in_addWorkoutInstance => _addWorkoutInstance.sink;

  BehaviorSubject<void> _removeAllWorkoutInstances = new BehaviorSubject();
  get in_removeAllWorkoutInstances => _removeAllWorkoutInstances.sink;


  WorkoutInstanceCatalogBloc({this.rawWorkoutInstanceCatalogBloc,
                              this.workoutTypeCatalogBloc,
                              this.exerciseTypeCatalogBloc}) {
    _addWorkoutInstance.listen(_handle_addWorkoutInstance);
    _removeAllWorkoutInstances.listen(_handle_removeAllWorkoutInstances);


    rawWorkoutInstanceCatalogBloc.out_rawEntitiesList.listen((list) {
      _currentRawWorkoutInstances = list;
      _rawWorkoutInstancesReady = true;
      if (_readyToMatch())
        match();
    });

    workoutTypeCatalogBloc.out_workoutTypesList.listen((list) {
      _currentWorkoutTypes = list;
      _workoutTypesReady = true;
      if (_readyToMatch())
        match();
    });

    exerciseTypeCatalogBloc.out_rawEntitiesList.listen((list) {
      _currentExerciseTypes = list;
      _exerciseTypesReady = true;
      if (_readyToMatch())
        match();
    });


  }


  bool _readyToMatch() {
    return _rawWorkoutInstancesReady
        && _workoutTypesReady
        && _exerciseTypesReady;
  }


  void match() {
    List<WorkoutInstance> list = _currentRawWorkoutInstances
      .map((rwi) {
        WorkoutInstance workoutInstance = WorkoutInstance()
          ..id = rwi.id
          ..workoutType = _currentWorkoutTypes.where((wt) => wt.id == rwi.workoutTypeId).toList().first
          ..workoutDate = rwi.workoutDate
          ..exerciseInstances = rwi.exerciseInstancesStrings
            .map((eis) {
              ExerciseType exerciseType = _currentExerciseTypes
                  .where((et) => et.id == ExerciseInstance.idFromString(eis))
                  .toList()
                  .first;
              ExerciseInstance exerciseInstance = ExerciseInstance()
                ..exerciseType = exerciseType;
              exerciseInstance = ExerciseInstance.mutateTraitsFromString(exerciseInstance, eis);

              return exerciseInstance;
            })
            .toList();

        return workoutInstance;
      })
      .toList();

    _in_workoutInstancesList.add(list);
  }


  void _handle_addWorkoutInstance(WorkoutInstance workoutInstance) {
    rawWorkoutInstanceCatalogBloc.in_addRawEntity.add(workoutInstance.toRaw());
  }

  void _handle_removeAllWorkoutInstances(void _) {
    rawWorkoutInstanceCatalogBloc.in_removeAllRawEntities.add(_);
  }



  @override
  void dispose() {
    _addWorkoutInstance.close();
    _removeAllWorkoutInstances.close();
    _workoutInstancesList.close();
  }
}