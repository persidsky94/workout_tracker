import 'package:flutter/material.dart';

import 'blocs/BlocProvider.dart';
import 'blocs/ExerciseTypeCatalogBloc.dart';
import 'pages/UserDefinedExerciseTypes.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseTypeCatalogBloc>(
      bloc: ExerciseTypeCatalogBloc(),
      child: MaterialApp(
        title: 'Workout tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage('Workout tracker'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String _title;
  MyHomePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _openExerciseTypesPage(context),
              child: Text("Exercise types list"),
            ),
          ],
        ),
      ),
    );
  }

  void _openExerciseTypesPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return UserDefinedExerciseTypesPage();
                }
        )
    );
  }
}
