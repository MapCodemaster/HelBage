import 'package:helbage/app/route.locator.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/model/tagModel.dart';
import 'package:helbage/model/userModel.dart';
import 'package:helbage/model/vehicleModel.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/view/admin/CollectionPoint/collectionListScreen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SummaryViewModel extends BaseViewModel{
  
  final _navigationService = locator<NavigationService>();
  final stor = locator<storage_service>();
  List<UserModel> uList = [];
  List<CollectionPointModel> cList = [];
  List<NewsModel> nList = [];

  @override
  SummaryViewModel(){
    fetchData();
  }

  void fetchData(){
    var user =
        stor.readCollectionAsStream("user").listen((event) {});
    user.onData((data) {
      uList = data.docs.map((e) => UserModel.fromJson(e.data())).toList();
      notifyListeners();
    } 
    );

    var collection =
        stor.readCollectionAsStream("point").listen((event) {});
    collection.onData((data) {
      cList = data.docs.map((e) => CollectionPointModel.fromJson(e.data(), e.id)).toList();
      notifyListeners();
    } 
    );

    var news =
        stor.readCollectionAsStream("news").listen((event) {});
    news.onData((data) {
      nList = data.docs.map((e) => NewsModel.fromJson(e.data(), e.id)).toList();
      notifyListeners();
    } 
    );
  }

  String returnUser (){
    int length = uList.length;
    String name = "$length";
    return name;
  }

  String returnCollection(){
    int length = cList.length;
    String c = "$length";
    return c;
  }

  String returnNews(){
    int length = nList.length;
    String n = "$length";
    return n;
  }

}

