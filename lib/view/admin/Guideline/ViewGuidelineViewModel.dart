import 'package:helbage/model/guideLineModel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/model/tagModel.dart';
import '../../../app/_route.dart';
import '../../../services/FirebaseServices/_services.dart';

class ViewGuidelineViewModel extends BaseViewModel
{
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final stor = locator<storage_service>();
  List<tagModel> tagList=new List.empty(growable: true);
  List<guidelineModel> guidelineList=new List.empty(growable: true);
  var tagListener;
  bool status=false;
  String? tag;
  ViewGuidelineViewModel()
  {
    status=true;
    getTag();
  }

  //read tag from firestore
  void getTag() async
  {
    var db = await stor.readDocumentAsStream("guidelinetag", "summary");
    print(db);
    //db.map((event){print((event.data()).toString());});
    try{
    tagListener=db.listen((event) { });
     tagListener.onData((data){
      
      print(data.get('tag'));
      data.get('tag').keys.toList().forEach((item)
      {
        tagList.add(new tagModel(name:item));
      });
    });
    }catch(e)
    {
      print(e.toString());
    }    

  }
  //trigger after tag selected
  void getGuideline(value) async
  {
    status=false;
    notifyListeners();
    guidelineList.clear();
    tag=value.toString();
    var db=await stor.readCollectionAsStreamArrayCondition('guideline','tag',value.toString());
    db.listen((event) { }).
    onData((data) {
    
     data.docs.forEach((element) {
      List<tagModel> tagList=guidelineModel.dynamicTagTotagModel(element['tag']);
      print(element.id);
      guidelineList.add(
        new guidelineModel.fromFireStore(
        docid: element.id,
        title: element['title'], 
        content: element['content'], 
        author: element['author'], 
        tag: tagList,
        datetime: element['datetime'].toDate())
      );
      }
        );//End For each
        status = true;notifyListeners();
        }
      
        );
        
        
  }
  
  @override
  void dispose()
  {
    tagListener.cancel();
  }
  void addGuideline()
  {
    _navigationService.navigateTo(Routes.addGuidelineView);
  }
  void viewGuideline()
  {

  }
}