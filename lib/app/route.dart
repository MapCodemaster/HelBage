import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/admin/CollectionPoint/editCollectionPointScreen.dart';
import 'package:helbage/view/admin/Guideline/addGuidelineView.dart';
import 'package:helbage/view/admin/Guideline/editGuidelineView.dart';
import 'package:helbage/view/admin/Guideline/singleGuidelineView.dart';
import 'package:helbage/view/admin/noticeboard/newsList.dart';
import 'package:helbage/view/admin/Schedule/createSchedule.dart';
import 'package:helbage/view/admin/Schedule/editScheduleView.dart';

import 'package:helbage/view/authentication/forgetPassword.dart';
import 'package:helbage/view/authentication/userSignUp.dart';
import 'package:helbage/view/home/homeScreen.dart';
import 'package:helbage/view/main/adminMainScreen.dart';
import 'package:helbage/view/main/residentMainScreen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/view/authentication/userLogin.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeScreen, initial: true),
  MaterialRoute(page: UserLogin),
  MaterialRoute(page: ResidentMainScreen),
  MaterialRoute(page: AdminMainScreen),
  MaterialRoute(page: ForgetPassword),
  MaterialRoute(page: UserSignUp),
  MaterialRoute(page: NewsList),
  MaterialRoute(page: CreateSchedule),
  MaterialRoute(page: EditScheduleView),
  MaterialRoute(page: AddGuidelineView),
  MaterialRoute(page: SingleGuidelineView),
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
