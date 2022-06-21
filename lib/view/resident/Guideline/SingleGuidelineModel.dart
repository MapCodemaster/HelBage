import 'package:helbage/app/_route.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/view/admin/Guideline/editGuidelineView.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/FirebaseServices/_services.dart';

class SingleGuidelineModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  guidelineModel workingGuideline;
  bool editable = false;
  SingleGuidelineModel({required this.workingGuideline}) {
    if (workingGuideline.author != "Admin" ||
        workingGuideline.author == auth.getUID()) {
      editable = false;
    }
  }
}
