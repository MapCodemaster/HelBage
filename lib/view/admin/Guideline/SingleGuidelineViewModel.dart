import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/model/userModel.dart';
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
  bool editable = true;
  SingleGuidelineViewModel({required this.workingGuideline})  {
    
    
    //setEditable();
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
  void setEditable() async
  {
    DocumentSnapshot snapshotc =
        await stor.read("user", auth.getUID());
    var temp = snapshotc.data() as Map<String, dynamic>;
    UserModel user = UserModel.fromJson(temp);

    if (user.userType.toString() == "Admin") {
      editable=true;
    }
    
  }
}
