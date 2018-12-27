import 'package:rxdart/rxdart.dart';


import 'BlocBase.dart';
import '../dataAccess/ExerciseTypeDatabaseHelper.dart';
import '../dataLayer/ExerciseType.dart';

class ExerciseTypeCatalogBloc extends BlocBase {

  BehaviorSubject<List<ExerciseType>> _exerciseTypes = new BehaviorSubject();
  get _in_exerciseTypes => _exerciseTypes.sink;
  get out_exerciseTypes => _exerciseTypes.stream;

  BehaviorSubject<ExerciseType> _addExerciseType = new BehaviorSubject();
  get in_addExerciseType => _addExerciseType.sink;
  get _out_addExerciseType => _addExerciseType.stream;

  BehaviorSubject<void> _removeAllExerciseTypes = new BehaviorSubject();
  get in_removeAllExerciseTypes => _removeAllExerciseTypes.sink;
  get _out_removeAllExerciseTypes => _removeAllExerciseTypes.stream;

//  BehaviorSubject<ExerciseType> _editExerciseType = new BehaviorSubject();
//  get in_editExersizeType => _editExerciseType.sink;
//  get _out_editExerciseType => _editExerciseType.stream;


  ExerciseTypeCatalogBloc() {
    _addExerciseType.listen(_handle_addExerciseType);
    _removeAllExerciseTypes.listen((void _) => _handle_removeAllExerciseTypes());
    //_editExerciseType.listen(_handle_editExerciseType);

    _updateExerciseTypesList();
  }

  @override
  void dispose() {
    _exerciseTypes.close();
    _addExerciseType.close();
    _removeAllExerciseTypes.close();
  }

  void _handle_addExerciseType(ExerciseType exerciseType) {
    _insertToDB(exerciseType).then((_) {
        _updateExerciseTypesList();
    });
  }

  void _handle_removeAllExerciseTypes() {
    ExerciseTypeDatabaseHelper.instance.deleteAll().then((_) {
      _updateExerciseTypesList();
    });
  }

  //void _handle_editExerciseType(ExerciseType editedExerciseType)

  Future<ExerciseType> _insertToDB(ExerciseType exerciseType) {
    return ExerciseTypeDatabaseHelper.instance.insert(exerciseType);
  }

  void _updateExerciseTypesList() {
    _getAllExerciseTypesFromDB().then((list) {
      _in_exerciseTypes.add(list);
    });
  }

  Future<List<ExerciseType>> _getAllExerciseTypesFromDB() {
    return ExerciseTypeDatabaseHelper.instance.getAllExerciseTypes();
  }

//  void _handle_editExerciseType(ExerciseType exerciseType) {
//
//  }
}