
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
                  return ListView.builder(
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return BlocProvider<ExerciseTypeCatalogBloc>(
                    bloc: _bloc,
                    child: NewExerciseTypePage(),
                  );
                }
            )
            );
          },
          child: Icon(Icons.add),
      ),

    );
  }


  Widget _buildExerciseTypeCard(BuildContext context, ExerciseType exerciseType) {
    var name = exerciseType.name;
    Widget _name = Text("Exercise: $name");

    List<Widget> _stats = [];
    if (exerciseType.hasWeight)
      _stats.add(Text("Has weight"));
    if (exerciseType.hasDuration)
      _stats.add(Text("Has duration"));
    if (exerciseType.hasTimes)
      _stats.add(Text("Has times"));
    if (exerciseType.hasRepetitions)
      _stats.add(Text("Has repetitions"));

    var _statsRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _stats,
    );

    return ListTile(
      title: _name,
      subtitle: _statsRow,
    );

  }
}