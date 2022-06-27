import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/model/guidelineRequestModel.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/admin/Guideline/pendingGuidelineView.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/_route.dart';
import '../../../services/FirebaseServices/storage_service.dart';

class processPendingGuidelineiViewModel extends BaseViewModel
{
  guidelineRequestModel workingRequest;
  final _navigationService = locator<NavigationService>();
  final stor = locator<storage_service>();
  List<dynamic> listener = new List.empty(growable: true);
  
  processPendingGuidelineiViewModel({required this.workingRequest});
  void approve()
  {
    
    addGuideline();
    updateRequest(true);
    _navigationService.navigateToView(pendingGuidelineView());
    
  }
  void reject()
  {
    updateRequest(true);
    _navigationService.navigateToView(pendingGuidelineView());
  }
  void addGuideline()
  {
    print(workingRequest.userId);
    guidelineModel guideline=workingRequest.getGuidelineModel();
        stor.add('guideline', guideline.toFirestore());
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
  void updateRequest(status)
  {
    stor.updateSingleField(firebaseConfig.guidelineRequest,workingRequest.docId.toString(), 'status', status);
    
  }
  @override
  void dispose() {
    listener.forEach((element) {
      element.cancel();
    });
  }
}