
import 'package:flutter/material.dart';

import '../blocs/BlocProvider.dart';
import '../blocs/WorkoutTypeCatalogBloc.dart';
import '../dataLayer/WorkoutType.dart';
import '../pages/NewWorkoutType.dart';
import '../widgets/WorkoutTypeCardListFromStream.dart';

class UserDefinedWorkoutTypesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    WorkoutTypeCatalogBloc workoutTypeCatalogBloc = BlocProvider.of<WorkoutTypeCatalogBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout types"),
      ),
      body: WorkoutTypeCardListFromStream(workoutTypeCatalogBloc.out_workoutTypesList),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _addNewWorkoutType(context, workoutTypeCatalogBloc),
            child: Icon(Icons.add, color: Colors.white),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _removeAllWorkoutTypes(workoutTypeCatalogBloc),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _addNewWorkoutType(BuildContext context, WorkoutTypeCatalogBloc workoutTypeCatalogBloc) async {
    WorkoutType workoutType = await Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (BuildContext context) {
          return NewWorkoutTypePage();
        }
    ));

    if (workoutType == null)
      return;

    workoutTypeCatalogBloc.in_addWorkoutType.add(workoutType);
  }


  void _removeAllWorkoutTypes(WorkoutTypeCatalogBloc bloc) {
    void a;
    bloc.in_removeAllWorkoutTypes.add(a);
  }

}