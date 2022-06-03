import 'package:helbage/services/FirebaseServices/DataPassingService.dart';
import 'package:helbage/services/FirebaseServices/FileStorage.dart';
import 'package:helbage/services/FirebaseServices/FirebaseAuth.dart';
import 'package:helbage/services/FirebaseServices/FirebaseFileStorage.dart';
import 'package:helbage/services/FirebaseServices/FirebaseStorage.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/view/admin/noticeboard/newsList.dart';
import 'package:helbage/view/authentication/ForgetPassword.dart';
import 'package:helbage/view/authentication/UserSignUp.dart';
import 'package:helbage/view/home/HomeScreen.dart';
import 'package:helbage/view/main/AdminMainScreen.dart';
import 'package:helbage/view/main/ResidentMainScreen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/view/authentication/UserLogin.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeScreen, initial: true),
  MaterialRoute(page: UserLogin),
  MaterialRoute(page: ResidentMainScreen),
  MaterialRoute(page: AdminMainScreen),
  MaterialRoute(page: ForgetPassword),
  MaterialRoute(page: UserSignUp),
  MaterialRoute(page: NewsList)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: FirebaseAuthService, asType: AuthService),
  LazySingleton(classType: FirebaseStor, asType: storage_service),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: FirebaseFileStorage, asType: FileStorage),
  Singleton(classType: DataPassingService)
])
class AppSetup {}
