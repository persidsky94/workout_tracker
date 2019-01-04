import 'package:flutter/material.dart';

import '../dataLayer/WorkoutType.dart';
import '../widgets/ExerciseTypeCardList.dart';


class WorkoutTypeCard extends StatelessWidget {
  final WorkoutType _workoutType;

  WorkoutTypeCard(this._workoutType);

  Widget build(BuildContext context) {
    var name = _workoutType.name;
    Widget _name = Text("Workout: $name");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: _name,
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ExerciseTypeCardList(_workoutType.exerciseTypes),
          ),
        ],
      )
    );
  }
}
