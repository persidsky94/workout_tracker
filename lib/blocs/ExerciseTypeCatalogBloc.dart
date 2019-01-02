
import 'RawEntityCatalogBloc.dart';
import '../dataAccess/ExerciseTypeDatabaseHelper.dart';
import '../dataAccess/SimpleEntityDatabaseHelper.dart';
import '../dataLayer/ExerciseType.dart';


class ExerciseTypeCatalogBloc extends RawEntityCatalogBloc<ExerciseType, ExerciseTypeDatabaseHelper> {

  @override
  SimpleEntityDatabaseHelper<ExerciseType> getDatabaseHelper() {
    return ExerciseTypeDatabaseHelper.instance;
  }

}