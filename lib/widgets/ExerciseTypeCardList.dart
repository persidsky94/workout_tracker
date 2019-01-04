import 'package:flutter/material.dart';

import '../dataLayer/ExerciseType.dart';
import 'ExerciseTypeCard.dart';



class ExerciseTypeCardList extends StatelessWidget {
  final List<ExerciseType> _exerciseTypesList;

  const ExerciseTypeCardList(this._exerciseTypesList);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          Expanded(
//            fit: FlexFit.loose,
//            child: ListView.separated(
            ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: _exerciseTypesList == null ? 0 : _exerciseTypesList.length,
              itemBuilder: (context, index) {
                return ExerciseTypeCard(_exerciseTypesList[index]);
              },
            ),
//          )
        ],
      ),
    );
  }
}