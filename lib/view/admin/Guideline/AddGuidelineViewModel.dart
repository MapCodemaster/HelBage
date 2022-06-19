import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/model/tagModel.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/_route.dart';
import '../../../services/FirebaseServices/_services.dart';

class AddGuidelineViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final stor = locator<storage_service>();
  Validation validate = Validation();
  List<dynamic> listener = new List.empty(growable: true);
  bool createGuideline(String title, String tag, String content, _formkey) {
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
      try {
        //#Test#TEst2
        List<String> tagStringList = tag.split('#');
        tagStringList.removeAt(0);
        List<tagModel> tagList = new List.empty(growable: true);

        tagStringList.forEach((element) {
          tagList.add(tagModel(name: element.toUpperCase()));
        });

        guidelineModel guideline = new guidelineModel(
            title: title, content: content, tag: tagList, author: "Admin");

        stor.add('guideline', guideline.toFirestore());
        //Map<String, dynamic> tempMap = new Map();
        var guidelineTagListener = stor
            .readDocumentAsStream("guidelinetag", "summary")
            .listen((event) {});

        guidelineTagListener.onData((data) {
          guidelineTagListener.cancel();
          var tagData = data.get('tag');
          Map convertMap = Map.castFrom(tagData);

          guideline.tag.forEach((element) {
            if (tagData["$element"] != null) {
              tagData["$element"] = tagData["$element"] + 1;
            } else {
              tagData["$element"] = 1;
            }
          });
          stor.updateSingleField('guidelinetag', 'summary', 'tag', tagData);
        });
        listener.add(guidelineTagListener);
      } catch (e) {
        print(e.toString());
      }
      _navigationService.back();
      return true;
    }
  }

  @override
  void dispose() {
    listener.forEach((element) {
      element.cancel();
    });
  }
}
