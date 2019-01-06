import 'package:flutter/material.dart';

import 'dart:async';

import '../blocs/BlocProvider.dart';
import '../blocs/ExerciseTypeCatalogBloc.dart';
import '../dataLayer/ExerciseType.dart';
import '../dataLayer/WorkoutType.dart';
import '../pages/SelectExerciseTypes.dart';
import '../widgets/ExerciseTypeCardList.dart';


class NewWorkoutTypePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New workout type"),
        ),
        body: Center(
            child: SingleChildScrollView(
              child: WorkoutTypeForm(),
            )
        )
    );
  }
}


class WorkoutTypeForm extends StatefulWidget {

  @override
  WorkoutTypeFormState createState() {
    return WorkoutTypeFormState();
  }
}

class WorkoutTypeFormState extends State<WorkoutTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final WorkoutType _workoutType = WorkoutType();


  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Workout name"
              ),
              validator: (value) {
                if (value.isEmpty)
                  return "Please enter workout's name";
              },
              onSaved: (String value) {
                _workoutType.name = value;
              },
            ),
            ExerciseTypeCardList(_workoutType.exerciseTypes),
            RaisedButton(
              onPressed: () => _addExerciseTypes(context),
              child: Text('Add exercise types to workout'),
            ),
            RaisedButton(
              onPressed: () => _removeExerciseTypes(context),
              child: Text('Remove exercise types from workout'),
            ),
            RaisedButton(
              onPressed: () => _returnWorkoutType(context),
              child: Text('Add workout type'),
            ),
          ],
        )
      ),
    );
  }

  void _returnWorkoutType(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pop(_workoutType);
    }
  }

  void _addExerciseTypes(BuildContext context) async {
    List<ExerciseType> selectedExerciseTypes = await Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (BuildContext context) {

          ExerciseTypeCatalogBloc bloc = BlocProvider.of<ExerciseTypeCatalogBloc>(context);
          Completer<List<ExerciseType>> completer = Completer();
          Future<List<ExerciseType>> futList = completer.future;
          bloc.out_rawEntitiesList.listen((exerciseTypesList) => completer.complete(exerciseTypesList));

          return SelectExerciseTypesPage(
              appBarText: 'Select exercise types',
              returnButtonText: 'Add selected exercise types',
              futureListToSelectFrom: futList,
          );
        }
    ));

    if (selectedExerciseTypes == null || selectedExerciseTypes.length == 0)
      return;

    setState(() {
      _workoutType.exerciseTypes.addAll(selectedExerciseTypes);
    });
  }

  void _removeExerciseTypes(BuildContext context) async {
    List<ExerciseType> exerciseTypesToRemove = await Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) {
        Future<List<ExerciseType>> futList = Future.value(_workoutType.exerciseTypes);

        return SelectExerciseTypesPage(
          appBarText: 'Remove exercise types',
          returnButtonText: 'Remove selected exercise types',
          futureListToSelectFrom: futList,
        );
      }
    ));

    if (exerciseTypesToRemove == null || exerciseTypesToRemove.length == 0)
      return;

    setState(() {
      _workoutType.exerciseTypes = _workoutType.exerciseTypes
          .map((et) => exerciseTypesToRemove.contains(et) ? null : et)
          .toList()
          .where((et) => et != null)
          .toList();
    });
  }

}