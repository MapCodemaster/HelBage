import 'package:helbage/app/_route.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/model/tagModel.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/SingleGuidelineView.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/FirebaseServices/_services.dart';

class EditGuidelineViewModel extends BaseViewModel
{
final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final stor = locator<storage_service>();
  Validation validate = Validation();
  List<dynamic> listener=new List.empty(growable: true);  
  guidelineModel? workingGuideline;
Future<bool> update(String title,String tag,String content,_formkey,guidelineModel originalGuideline) async
{
  if (!_formkey.currentState!.validate()) {
      return false;
    } 
    else {
    List<String> tagStringList=tag.split('#');
    tagStringList.removeAt(0);
    List<tagModel> tagList=new List.empty(growable: true);

    tagStringList.forEach((element) {tagList.add(tagModel(name:element.toUpperCase()));});
    
    guidelineModel guideline=new guidelineModel(title:title,content:content,tag: tagList,author: "Admin");
    workingGuideline=guideline;
    editGuideline(guideline,originalGuideline.docid,originalGuideline);    
    return true;
    }
}
void toSingleView()
{
  _navigationService.navigateToView(SingleGuidelineView(guideline: workingGuideline!));
}
  //remove the tag at original guideline
  void editTag(guideline,newGuideline)  
  {
    var guidelineTagListener=stor.readDocumentAsStream("guidelinetag", "summary").listen((event){});
    guidelineTagListener.onData((data) async {
    guidelineTagListener.cancel();
    var tagData=data.get('tag');
    guideline.tag.forEach((element) {
    if(tagData["$element"]!=1)
      {
        tagData["$element"]=tagData["$element"]-1;
      }
    else
      {
        tagData.remove("$element");
      }
      });
    await stor.updateSingleField('guidelinetag', 'summary', 'tag', tagData);
    await Future.delayed(const Duration(seconds: 2));
    addTag(newGuideline);

  });
  }
  void editGuideline(guideline,id,oldGuideline) async
  {
    
    guideline.docid=id;
    await stor.update(id, 'guideline', guideline.toFirestore());
    editTag(oldGuideline,guideline);
    
  }
  void addTag(guideline) 
  {
    var guidelineTagListener=stor.readDocumentAsStream("guidelinetag", "summary").listen((event){});
    guidelineTagListener.onData((data) {
    guidelineTagListener.cancel();
    var tagData=data.get('tag');
    guideline.tag.forEach((element) {
        if(tagData["$element"]!=null)
        {
          tagData["$element"]=tagData["$element"]+1;
        }
        else{
          tagData["$element"]=1;
        }
        
      });
      stor.updateSingleField('guidelinetag', 'summary', 'tag', tagData);
      
      });
  }
}