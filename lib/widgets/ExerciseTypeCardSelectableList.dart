import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';


import '../dataLayer/ExerciseType.dart';
import '../widgets/ExerciseTypeCard.dart';


class ExerciseTypeCardSelectableList extends StatelessWidget {
  List<ExerciseType> selectedExerciseTypes = List();
  BehaviorSubject<List<ExerciseType>> _selectedExerciseTypes = BehaviorSubject();
  final Future<List<ExerciseType>> futExerciseTypes;


  ExerciseTypeCardSelectableList(this.futExerciseTypes);

  @override
  Widget build(BuildContext context) {
    _selectedExerciseTypes.stream.listen(
            (selected) => selectedExerciseTypes = selected
    );

    return __ExerciseTypeCardSelectableList(_selectedExerciseTypes.sink, futExerciseTypes);
  }

}



class __ExerciseTypeCardSelectableList extends StatefulWidget {
  final Sink<List<ExerciseType>> _selectedExerciseTypesSink;
  final Future<List<ExerciseType>> futExerciseTypes;

  //  _ExerciseTypeCardSelectableListState _state;

  __ExerciseTypeCardSelectableList(this._selectedExerciseTypesSink, this.futExerciseTypes);

  @override
  State<StatefulWidget> createState() {
    return __ExerciseTypeCardSelectableListState(futExerciseTypes);
  }
}



class __ExerciseTypeCardSelectableListState extends State<__ExerciseTypeCardSelectableList> {
  final Future<List<ExerciseType>> futList;
  List<ExerciseType> _exerciseTypes;
  Map<ExerciseType, bool> _exerciseTypesSelect;

  List<ExerciseType> get selected {
    List<ExerciseType> selectedList = _exerciseTypesSelect
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return selectedList;
  }

  __ExerciseTypeCardSelectableListState(this.futList);

  @override
  void initState() {
    super.initState();

    futList.then((list) => _internalInit(list));
  }

  void _internalInit(List<ExerciseType> list) {
    _exerciseTypes = list;

    Map<ExerciseType, bool> initMap = Map();
    List<MapEntry<ExerciseType, bool>> newMapEntries =_exerciseTypes
        .map((et) => MapEntry<ExerciseType, bool>(et, false))
        .toList();
    initMap.addEntries(newMapEntries);
    _exerciseTypesSelect = initMap;

    setState(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemCount: _exerciseTypes == null ? 0 : _exerciseTypes.length,
            itemBuilder: (context, index) {
              ExerciseType exerciseType = _exerciseTypes[index];
              return ExerciseTypeCard(
                  exerciseType,
                  isSelected: _exerciseTypesSelect[exerciseType],
                  onTapCallback: _switchSelection,
              );
            },
          ),
        ],
      ),
    );
  }

  void _switchSelection(ExerciseType exerciseType) {
    bool isSelected = _exerciseTypesSelect[exerciseType];
    _exerciseTypesSelect[exerciseType] = !isSelected;
    var selectedExercises = selected;
    widget._selectedExerciseTypesSink.add(selectedExercises);
    setState(() => null);
  }
}