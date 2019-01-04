import 'package:flutter/material.dart';

import '../dataLayer/ExerciseType.dart';
import 'ExerciseTypeCard.dart';



class ExerciseTypeCardListFromStream extends StatelessWidget {
  final Stream<List<ExerciseType>> _exerciseTypesListStream;

  const ExerciseTypeCardListFromStream(this._exerciseTypesListStream);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: StreamBuilder<List<ExerciseType>>(
                stream: _exerciseTypesListStream,
                builder: (BuildContext context, AsyncSnapshot<List<ExerciseType>> list) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    itemCount: list.data == null ? 0 : list.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExerciseTypeCard(list.data[index]);
                    },
                  );
                },
              )
          )
        ],
      ),
    );
  }

}