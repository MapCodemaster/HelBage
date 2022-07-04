import 'package:helbage/app/_route.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/services/FileService/pdfServices.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/FirebaseServices/_services.dart';

class SingleGuidelineModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  final pdfConverter = locator<pdfServices>();

  guidelineModel workingGuideline;
  bool editable = false;
  SingleGuidelineModel({required this.workingGuideline}) {
    if (workingGuideline.author != "Admin" ||
        workingGuideline.author == auth.getUID()) {
      editable = false;
    }
  }

  void toPDF() async {
    if (await pdfConverter.toPDF(workingGuideline)) {
      await _dialogService.showDialog(
          title: "File downloaded",
          description: "Pdf file downloaded in files folder ",
          dialogPlatform: DialogPlatform.Material);
    }
  }
}
