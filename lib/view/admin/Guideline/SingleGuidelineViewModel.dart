import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/model/userModel.dart';
import 'package:helbage/services/FileService/pdfServices.dart';
import 'package:helbage/view/admin/Guideline/editGuidelineView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../services/FirebaseServices/_services.dart';

class SingleGuidelineViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  final pdfConverter = locator<pdfServices>();
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
  void toPDF() async
  {
    if(await pdfConverter.toPDF(workingGuideline))
    {
     _dialogService.showDialog(
              title: "File downloaded",
              description: "Pdf file downloaded in folder helbage",
              dialogPlatform: DialogPlatform.Material);
    }
  }
  

  
}
