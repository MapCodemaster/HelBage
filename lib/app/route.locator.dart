// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:helbage/services/FirebaseServices/localNotification.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/FirebaseServices/_services.dart';

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
  locator.registerLazySingleton<PushNotificationService>(
      () => LocalNotification());
}
