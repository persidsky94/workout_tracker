import 'package:flutter/material.dart';

import 'blocs/BlocProvider.dart';
import 'blocs/ExerciseTypeCatalogBloc.dart';
import 'blocs/RawWorkoutTypeCatalogBloc.dart';
import 'blocs/WorkoutTypeCatalogBloc.dart';
import 'blocs/WorkoutInstanceCatalogBloc.dart';
import 'blocs/RawWorkoutInstanceCatalogBloc.dart';
import 'pages/UserDefinedExerciseTypes.dart';
import 'pages/UserDefinedWorkoutTypes.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExerciseTypeCatalogBloc exerciseTypeCatalogBloc = ExerciseTypeCatalogBloc();
    RawWorkoutTypeCatalogBloc rawWorkoutTypeCatalogBloc = RawWorkoutTypeCatalogBloc();
    WorkoutTypeCatalogBloc workoutTypeCatalogBloc = WorkoutTypeCatalogBloc(exerciseTypeCatalogBloc, rawWorkoutTypeCatalogBloc);
    RawWorkoutInstanceCatalogBloc rawWorkoutInstanceCatalogBloc = RawWorkoutInstanceCatalogBloc();
    WorkoutInstanceCatalogBloc workoutInstanceCatalogBloc =
      WorkoutInstanceCatalogBloc(
          rawWorkoutInstanceCatalogBloc: rawWorkoutInstanceCatalogBloc,
          workoutTypeCatalogBloc: workoutTypeCatalogBloc,
          exerciseTypeCatalogBloc: exerciseTypeCatalogBloc,
      );

    return BlocProvider<ExerciseTypeCatalogBloc>(
      bloc: exerciseTypeCatalogBloc,
      child: BlocProvider<RawWorkoutTypeCatalogBloc>(
        bloc: rawWorkoutTypeCatalogBloc,
        child: BlocProvider<WorkoutTypeCatalogBloc>(
          bloc: workoutTypeCatalogBloc,
          child: BlocProvider<RawWorkoutInstanceCatalogBloc>(
            bloc: rawWorkoutInstanceCatalogBloc,
            child: BlocProvider<WorkoutInstanceCatalogBloc>(
              bloc: workoutInstanceCatalogBloc,
              child: MaterialApp(
                title: 'Workout tracker',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: MyHomePage('Workout tracker'),
              ),
            )
          )
        ),
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String _title;
  MyHomePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _openExerciseTypesPage(context),
              child: Text("Exercise types list"),
            ),
            RaisedButton(
              onPressed: () => _openWorkoutTypesPage(context),
              child: Text("Workout types list"),
            ),
          ],
        ),
      ),
    );
  }

  void _openExerciseTypesPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return UserDefinedExerciseTypesPage();
                }
        )
    );
  }

  void _openWorkoutTypesPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (BuildContext context) {
          return UserDefinedWorkoutTypesPage();
        }
    )
    );
  }
}
