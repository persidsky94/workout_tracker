
import 'package:flutter/material.dart';

import '../blocs/BlocProvider.dart';
import '../blocs/ExerciseTypeCatalogBloc.dart';
import '../dataLayer/ExerciseType.dart';
import '../pages/NewExerciseType.dart';


class UserDefinedExerciseTypesPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ExerciseTypeCatalogBloc _bloc = BlocProvider.of<ExerciseTypeCatalogBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise types"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<ExerciseType>>(
                stream: _bloc.out_exerciseTypes,
                builder: (BuildContext context, AsyncSnapshot<List<ExerciseType>> list) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    itemCount: list.data == null ? 0 : list.data.length,
                    itemBuilder: (BuildContext context, int index) {
                        return _buildExerciseTypeCard(context, list.data[index]);
                    },
                  );
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _openNewExerciseTypePage(context),
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _removeAllExerciseTypes(_bloc),
            child: Icon(Icons.delete,color: Colors.white,),
          ),
        ],
      ),
    );
  }

  void _removeAllExerciseTypes(ExerciseTypeCatalogBloc bloc) {
    void a;
    bloc.in_removeAllExerciseTypes.add(a);
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


  Widget _buildExerciseTypeCard(BuildContext context, ExerciseType exerciseType) {
    var name = exerciseType.name;
    Widget _name = Text("Exercise: $name");

    List<Widget> _stats = [];
    if (exerciseType.hasWeight)
      _stats.add(Icon(Icons.fitness_center, color: Colors.blue));
    if (exerciseType.hasDuration)
      _stats.add(Icon(Icons.access_time, color: Colors.blue));
    if (exerciseType.hasTimes)
      _stats.add(Icon(Icons.repeat, color: Colors.blue));
    if (exerciseType.hasRepetitions)
      _stats.add(Icon(Icons.loop, color: Colors.blue));

//    var _statsRow = Row(
//      mainAxisAlignment: MainAxisAlignment.end,
//      children: _stats,
//    );

    return ListTile(
      //title: _name,
      //subtitle: _statsRow,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _name,
              ),
            ],
          )),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: _stats,
          ),
        ],
      )
    );

  }
}