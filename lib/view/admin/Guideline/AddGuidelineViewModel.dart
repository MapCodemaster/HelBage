import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/model/guidelineRequestModel.dart';
import 'package:helbage/model/tagModel.dart';
import 'package:helbage/services/FirebaseServices/firebaseConfig.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/_route.dart';
import '../../../services/FirebaseServices/_services.dart';

class AddGuidelineViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final stor = locator<storage_service>();
  final auth=locator<AuthService>();
  bool isAdmin;
  Validation validate = Validation();
  List<dynamic> listener = new List.empty(growable: true);

  AddGuidelineViewModel({required this.isAdmin});

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
        dynamic author="Admin";
        if(!isAdmin)
        {

          userAdd(tag: tagList,title:title,content: content);
        }
        else
        {

          adminAdd(tag: tagList,title: title,content: content);
        }
      } catch (e) {
        
      }
      _navigationService.back();
      return true;
    }
  }


  //add Guiline to guideline request collection
  void userAdd({required tag, required title, required content})
  {
    try{
    String uid=auth.getUID();
    
    String? authorName;
    var author=stor.read(firebaseConfig.user,uid).then((value) {authorName=value.get('name');});
    author.whenComplete((() async {
    guidelineRequestModel request=guidelineRequestModel(author: authorName, tag: tag, title: title, content: content,authorId:uid);
    bool result=false;
    await stor.addByIModel(firebaseConfig.guidelineRequest, request).then((value) {result=value;});
    if(result)
    {
       _dialogService.showDialog(
              title: "Post Submitted",
              description: "Your post has been sent. It will be published once admin approve it",
              dialogPlatform: DialogPlatform.Material);
    }
    }));
    }
    catch(e)
    {
      throw Exception("Error in adding");
    }
  }

  //add guideline to guideline collection
  void adminAdd({required title,required content, required tag})
  {
    guidelineModel guideline = new guidelineModel(
            title: title, content: content, tag: tag, author: "Admin");

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

  }
  @override
  void dispose() {
    listener.forEach((element) {
      element.cancel();
    });
  }
}
