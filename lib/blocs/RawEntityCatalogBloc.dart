import 'package:rxdart/rxdart.dart';


import 'BlocBase.dart';
import '../dataAccess/SimpleEntityDatabaseHelper.dart';
//import '../dataLayer/RawEntity.dart';

abstract class RawEntityCatalogBloc<RawEntity, RawEntityDatabaseHelper extends SimpleEntityDatabaseHelper<RawEntity>> extends BlocBase {
  
  SimpleEntityDatabaseHelper<RawEntity> getDatabaseHelper();
  

  BehaviorSubject<List<RawEntity>> _rawEntitiesList = new BehaviorSubject();
  get _in_rawEntitiesList => _rawEntitiesList.sink;
  get out_rawEntitiesList => _rawEntitiesList.stream;

  BehaviorSubject<RawEntity> _addRawEntity = new BehaviorSubject();
  get in_addRawEntity => _addRawEntity.sink;

  BehaviorSubject<void> _removeAllRawEntities = new BehaviorSubject();
  get in_removeAllRawEntities => _removeAllRawEntities.sink;


  RawEntityCatalogBloc() {
    _addRawEntity.listen(_handle_addRawEntity);
    _removeAllRawEntities.listen((void _) => _handle_removeAllRawEntities());
  
    _updateRawEntitiesList();
  }

  @override
  void dispose() {
    _rawEntitiesList.close();
    _addRawEntity.close();
    _removeAllRawEntities.close();
  }

  void _handle_addRawEntity(RawEntity rawEntity) {
    _insertToDB(rawEntity).then((_) => _updateRawEntitiesList());
  }

  void _handle_removeAllRawEntities() {
    getDatabaseHelper().deleteAll()
        .then((_) => _updateRawEntitiesList());
  }

  Future<RawEntity> _insertToDB(RawEntity rawEntity) {
    return getDatabaseHelper().insert(rawEntity);
  }

  void _updateRawEntitiesList() {
    _getAllRawEntitiesFromDB()
        .then((list) => _in_rawEntitiesList.add(list));
  }

  Future<List<RawEntity>> _getAllRawEntitiesFromDB() {
    return getDatabaseHelper().getAllEntities();
  }

}