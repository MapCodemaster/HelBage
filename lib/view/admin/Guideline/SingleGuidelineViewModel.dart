import 'package:helbage/app/_route.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/view/admin/Guideline/editGuidelineView.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/FirebaseServices/_services.dart';

class SingleGuidelineViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  guidelineModel workingGuideline;
  bool editable = false;
  SingleGuidelineViewModel({required this.workingGuideline}) {
    if (workingGuideline.author == "Admin" ||
        workingGuideline.author == auth.getUID()) {
      editable = true;
    }
  }
  void edit(guideline) {
    _navigationService.navigateToView(EditGuidelineView(guideline: guideline));
  }

  void delete(guidelineModel guideline) async {
    stor.delete(guideline.docid.toString(), 'guideline');
    var guidelineTagListener =
        stor.readDocumentAsStream("guidelinetag", "summary").listen((event) {});
    guidelineTagListener.onData((data) {
      guidelineTagListener.cancel();
      var tagData = data.get('tag');
      guideline.tag.forEach((element) {
        if (tagData["$element"] != 1) {
          tagData["$element"] = tagData["$element"] - 1;
        } else {
          tagData.remove("$element");
        }
      });
      stor.updateSingleField('guidelinetag', 'summary', 'tag', tagData);
      guidelineTagListener.cancel();

      _navigationService.back();
    });
  }
}
