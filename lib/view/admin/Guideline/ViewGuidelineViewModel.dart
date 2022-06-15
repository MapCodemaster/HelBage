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
  var tagListener;

  ViewGuidelineViewModel()
  {
    getTag();
  }
  
  void getTag() async
  {
    var db = await stor.readDocumentAsStream("guideline", "tag");
    print(db);
    //db.map((event){print((event.data()).toString());});
    try{
    tagListener=db.listen((event) { });
     tagListener.onData((data){
      print(data.toString());
      data['guidelinetag'].forEach((item)
      {
        tagList.add(new tagModel(name:item.toString()));
      });
    });
    }catch(e)
    {
      print(e.toString());
    }    
  
  }

  void getGuideline(value) async
  {
    
    var db=await stor.readCollectionAsStreamArrayCondition('guideline','Tag',value.toString());
    db.listen((event) { }).
    onData((data) {
     data.docs.forEach((element) { 
        print(element['title']);}
        );
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
}