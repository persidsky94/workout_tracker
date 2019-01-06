import 'package:flutter/material.dart';

import 'dart:async';

import '../dataLayer/ExerciseType.dart';
import '../widgets/ExerciseTypeCardSelectableList.dart';


class SelectExerciseTypesPage extends StatelessWidget {
  final String appBarText;
  final String returnButtonText;
  final Future<List<ExerciseType>> futureListToSelectFrom;

  SelectExerciseTypesPage(
  {
    this.appBarText,
    this.returnButtonText,
    this.futureListToSelectFrom,
  }
  );

  @override
  Widget build(BuildContext context) {
    var selectableList = ExerciseTypeCardSelectableList(futureListToSelectFrom);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Center(
        child:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              selectableList,
              RaisedButton(
                child: Text(returnButtonText),
                onPressed: () => _returnSelectedExerciseTypes(context, selectableList),
              )
            ],
          )
        )
      ),
    );
  }

  void _returnSelectedExerciseTypes(BuildContext context, ExerciseTypeCardSelectableList selectableList) {
    Navigator.of(context).pop(selectableList.selectedExerciseTypes);
  }

}