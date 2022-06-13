import 'package:helbage/app/route.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FilterDialogViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void filter(String? option) {
    _navigationService.back(result: option);
  }

  void pop() {
    _navigationService.back();
  }
}
