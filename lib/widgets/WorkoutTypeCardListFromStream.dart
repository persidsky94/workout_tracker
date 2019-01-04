import 'package:flutter/material.dart';

import 'WorkoutTypeCard.dart';
import '../dataLayer/WorkoutType.dart';

class WorkoutTypeCardListFromStream extends StatelessWidget {
  final Stream<List<WorkoutType>> _workoutTypesStream;

  WorkoutTypeCardListFromStream(this._workoutTypesStream);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<WorkoutType>>(
              stream: _workoutTypesStream,
              builder: (BuildContext context, AsyncSnapshot<List<WorkoutType>> list) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                    itemCount: list.data == null ? 0 : list.data.length,
                    itemBuilder: (context, index) => WorkoutTypeCard(list.data[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}