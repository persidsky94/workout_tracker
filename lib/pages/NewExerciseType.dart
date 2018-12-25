import 'package:flutter/material.dart';

import '../blocs/BlocProvider.dart';
import '../blocs/ExerciseTypeCatalogBloc.dart';
import '../dataLayer/ExerciseType.dart';


class NewExerciseTypePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New exercise type"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ExerciseTypeForm(),
        )
      )
    );
  }
}

class ExerciseTypeForm extends StatefulWidget {

  @override
  ExerciseTypeFormState createState() {
    return ExerciseTypeFormState();
  }
}

class ExerciseTypeFormState extends State<ExerciseTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _exerciseTypeMap = {
    '$columnWeight' : 0,
    '$columnDuration' : 0,
    '$columnRepetitions' : 0,
    '$columnTimes' : 0,
  };


  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ExerciseTypeCatalogBloc>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: "Exercise name"
            ),
            validator: (value) {
              if (value.isEmpty)
                return "Please enter exercise's name";
            },
            onSaved: (String value) {
              _exerciseTypeMap['$columnName'] = value;
            },
          ),
          _getSimpleCheckboxListTile('Weight', '$columnWeight'),
          _getSimpleCheckboxListTile('Duration', '$columnDuration'),
          _getSimpleCheckboxListTile('Repetitions', '$columnRepetitions'),
          _getSimpleCheckboxListTile('Times', '$columnTimes'),
          Container(

            child: RaisedButton(
              onPressed: () {
                _submit(context, bloc);
              },
              child: Text('Add new Exercise Type'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSimpleCheckboxListTile(String title, String mapString) {
    return CheckboxListTile(
      title: Text('$title'),
      value: (_exerciseTypeMap['$mapString'] == 1 ? true : false),
      onChanged: (bool value) {
        setState(() {
          _exerciseTypeMap['$mapString'] = (value == true ? 1 : 0);
        });
      },
    );
  }

  void _submit(BuildContext context, ExerciseTypeCatalogBloc bloc) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bloc.in_addExerciseType.add(ExerciseType.fromMap(_exerciseTypeMap));
      Navigator.pop(context);
    }
  }


}
