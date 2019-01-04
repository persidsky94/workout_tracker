
import 'package:flutter/material.dart';
import 'dart:math';

import '../blocs/BlocProvider.dart';
import '../blocs/ExerciseTypeCatalogBloc.dart';
import '../blocs/WorkoutTypeCatalogBloc.dart';
import '../dataLayer/ExerciseType.dart';
import '../dataLayer/WorkoutType.dart';
import '../widgets/WorkoutTypeCardListFromStream.dart';

class UserDefinedWorkoutTypesPage extends StatelessWidget {
  List<ExerciseType> _exerciseTypes;


  @override
  Widget build(BuildContext context) {

    WorkoutTypeCatalogBloc _bloc = BlocProvider.of<WorkoutTypeCatalogBloc>(context);
    ExerciseTypeCatalogBloc bloc = BlocProvider.of<ExerciseTypeCatalogBloc>(context);

    bloc.out_rawEntitiesList.listen((list) => _exerciseTypes = list);


    return Scaffold(
      appBar: AppBar(
        title: Text("Workout types"),
      ),
      body: WorkoutTypeCardListFromStream(_bloc.out_workoutTypesList),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _addFixedWorkoutType(_bloc, context),
            child: Icon(Icons.add, color: Colors.white),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _removeAllWorkoutTypes(_bloc),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _addFixedWorkoutType(WorkoutTypeCatalogBloc bloc, BuildContext context) {
    WorkoutType wt = __createCustomWorkoutType(context);
    bloc.in_addWorkoutType.add(wt);
  }

  void _removeAllWorkoutTypes(WorkoutTypeCatalogBloc bloc) {
    void a;
    bloc.in_removeAllWorkoutTypes.add(a);
  }

  WorkoutType __createCustomWorkoutType(BuildContext context) {
    WorkoutType workoutType = WorkoutType();
    workoutType.name = 'FeelsGood train';
    _exerciseTypes.shuffle();
    Random random = Random();
    int numExercises = random.nextInt(4)+2;
    numExercises = min(numExercises, _exerciseTypes.length);
    workoutType.exerciseTypes = _exerciseTypes
                                  .take(numExercises)
                                  .toList();
    return workoutType;
  }

}