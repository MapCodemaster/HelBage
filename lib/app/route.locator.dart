// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/FirebaseServices/DataPassingService.dart';
import '../services/FirebaseServices/FileStorage.dart';
import '../services/FirebaseServices/FirebaseAuth.dart';
import '../services/FirebaseServices/FirebaseFileStorage.dart';
import '../services/FirebaseServices/FirebaseStorage.dart';
import '../services/FirebaseServices/auth_service.dart';
import '../services/FirebaseServices/storage_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  locator.registerLazySingleton<storage_service>(() => FirebaseStor());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton<FileStorage>(() => FirebaseFileStorage());
  locator.registerSingleton(DataPassingService());
}
