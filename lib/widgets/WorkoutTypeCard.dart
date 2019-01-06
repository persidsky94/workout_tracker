import 'package:flutter/material.dart';

import '../dataLayer/WorkoutType.dart';
import '../widgets/ExerciseTypeCardList.dart';


class WorkoutTypeCard extends StatefulWidget {
  final WorkoutType _workoutType;

  WorkoutTypeCard(this._workoutType);


  @override
  State<StatefulWidget> createState() {
    return _WorkoutTypeCardState();
  }
}

class _WorkoutTypeCardState extends State<WorkoutTypeCard>{
  bool _isExercisesListVisible = false;

  Widget build(BuildContext context) {
    var name = widget._workoutType.name;
    Widget _name = Text("Workout: $name");
    Visibility exerciseTypesCards = Visibility(
        visible: _isExercisesListVisible,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: ExerciseTypeCardList(widget._workoutType.exerciseTypes),
        ),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            color: Colors.blue,
            child: ListTile(
              title: _name,
              onTap: () {
                setState(() {
                  _isExercisesListVisible = !_isExercisesListVisible;
                });
              },
            ),
          ),
//          Divider(
//            color: Colors.grey,
//          ),
          exerciseTypesCards,
        ],
      )
    );
  }

}
