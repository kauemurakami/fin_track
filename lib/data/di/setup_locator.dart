import 'package:fin_track/core/services/db/db.dart';
import 'package:fin_track/core/services/navigation.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DBService>(() => DBService());
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
}
