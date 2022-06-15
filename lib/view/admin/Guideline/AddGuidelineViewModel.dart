import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/_route.dart';
import '../../../services/FirebaseServices/_services.dart';

class AddGuidelineViewModel extends BaseViewModel
{
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final stor = locator<storage_service>();
  Validation validate = Validation();
  bool createGuideline(title,tag,content,_formkey)
  {
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
    print(title);
    print(tag);
    print(content);
    return true;
    }
  }
}