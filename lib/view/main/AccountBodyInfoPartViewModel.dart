import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/app/_route.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountBodyInfoPartViewModel extends StreamViewModel<UserModel> {
  final storageService = locator<storage_service>();
  final _auth = locator<AuthService>();
  final navigate = locator<NavigationService>();
  @override
  Stream<UserModel> get stream => fetchUserInfo();
  Stream<UserModel> fetchUserInfo() {
    return storageService
        .readDocumentAsStream("user", _auth.getUID())
        .map((event) => UserModel.fromJson(event.data()));
  }
}
