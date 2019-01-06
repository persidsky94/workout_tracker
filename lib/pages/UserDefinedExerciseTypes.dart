
import 'package:flutter/material.dart';

import '../blocs/BlocProvider.dart';
import '../blocs/ExerciseTypeCatalogBloc.dart';
import '../pages/NewExerciseType.dart';
import '../widgets/ExerciseTypeCardListFromStream.dart';


class UserDefinedExerciseTypesPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ExerciseTypeCatalogBloc _exerciseTypeCatalogBloc = BlocProvider.of<ExerciseTypeCatalogBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise types"),
      ),
      body: ExerciseTypeCardListFromStream(_exerciseTypeCatalogBloc.out_rawEntitiesList),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _openNewExerciseTypePage(context),
            child: Icon(Icons.add, color: Colors.white,),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _removeAllExerciseTypes(_exerciseTypeCatalogBloc),
            child: Icon(Icons.delete, color: Colors.white,),
          ),
        ],
      ),
    );
  }

  void _removeAllExerciseTypes(ExerciseTypeCatalogBloc bloc) {
    void a;
    bloc.in_removeAllRawEntities.add(a);
  }

  void _openNewExerciseTypePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) {
            return  NewExerciseTypePage();
          }
        )
    );
  }
}