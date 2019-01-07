
import 'RawEntityCatalogBloc.dart';
import '../dataAccess/SimpleEntityDatabaseHelper.dart';
import '../dataAccess/RawWorkoutInstanceDatabaseHelper.dart';
import '../dataLayer/RawWorkoutInstance.dart';

class RawWorkoutInstanceCatalogBloc extends RawEntityCatalogBloc<RawWorkoutInstance, RawWorkoutInstanceDatabaseHelper> {

  @override
  SimpleEntityDatabaseHelper<RawWorkoutInstance> getDatabaseHelper() {
    return RawWorkoutInstanceDatabaseHelper.instance;
  }

}