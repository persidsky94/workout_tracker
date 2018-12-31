import 'package:flutter/material.dart';

import '../dataLayer/ExerciseType.dart';


class ExerciseTypeCard extends StatelessWidget {
  final ExerciseType _exerciseType;

  const ExerciseTypeCard(this._exerciseType);


  Widget build(BuildContext context) {
    var name = _exerciseType.name;
    Widget _name = Text("Exercise: $name");

    List<Widget> _stats = [];
    if (_exerciseType.hasWeight)
      _stats.add(Icon(Icons.fitness_center, color: Colors.blue));
    if (_exerciseType.hasDuration)
      _stats.add(Icon(Icons.access_time, color: Colors.blue));
    if (_exerciseType.hasTimes)
      _stats.add(Icon(Icons.repeat, color: Colors.blue));
    if (_exerciseType.hasRepetitions)
      _stats.add(Icon(Icons.loop, color: Colors.blue));

    return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Row(
              children: <Widget>[
                Expanded(
                  child: _name,
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _stats,
            ),
          ],
        )
    );
  }
}