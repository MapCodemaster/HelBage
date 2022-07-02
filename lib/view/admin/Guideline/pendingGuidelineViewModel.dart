import 'package:helbage/model/guidelineRequestModel.dart';
import 'package:helbage/services/FirebaseServices/firebaseConfig.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/view/admin/Guideline/processPendingGuidelineView.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/_route.dart';

class pendingGuidelineViewModel extends BaseViewModel
{
  final _navigationService = locator<NavigationService>();
  final stor = locator<storage_service>();
  List<guidelineRequestModel> requestList=List.empty(growable: true);
  pendingGuidelineViewModel()
  {
    readData();
  }
  void readData()
  {
    
    //stor.readCollectionAsStream(firebaseConfig.guidelineRequest)
    stor.readCollectionAsStreamCondition(firebaseConfig.guidelineRequest,'status',false).listen((event) { }).onData((data) {
      requestList.clear();
      data.docs.forEach((element){
        print(element['authorId']);
        if(!element['status'])
        {
          requestList.add(guidelineRequestModel.FromFireStore(element));
        }
        
        notifyListeners();
      });
      
    });
  }


  //get document id and navigate to view details of guideline post request
  void navigateToProcess(guidelineRequest)
  {
     _navigationService.navigateToView(processPendingGuidelineView(request: guidelineRequest));
  }
}