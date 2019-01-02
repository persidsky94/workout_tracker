
import 'RawEntityCatalogBloc.dart';
import '../dataAccess/RawWorkoutTypeDatabaseHelper.dart';
import '../dataAccess/SimpleEntityDatabaseHelper.dart';
import '../dataLayer/RawWorkoutType.dart';

class RawWorkoutTypeCatalogBloc extends RawEntityCatalogBloc<RawWorkoutType, RawWorkoutTypeDatabaseHelper> {

  @override
  SimpleEntityDatabaseHelper<RawWorkoutType> getDatabaseHelper() {
    return RawWorkoutTypeDatabaseHelper.instance;
  }

}