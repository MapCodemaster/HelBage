import 'package:helbage/app/route.locator.dart';
import 'package:helbage/model/reminderModel.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScheduleReminderDialogViewModel extends BaseViewModel {
  final navigator = locator<NavigationService>();
  final stor = locator<storage_service>();
  final auth = locator<AuthService>();
  void closeDialog() {
    navigator.back();
  }

  void save(ReminderModel reminder, bool isSet, scheduleModel schedule) {
    reminder.status = isSet;
    if (reminder.userID == "" || reminder.userID == null) {
      reminder.docID = stor.getCreatedDocumentID("reminder");
      reminder.userID = auth.getUID();
      reminder.schedule =
          "schedule/" + schedule.state + "/Path/" + schedule.pathName;
      stor.insert(reminder.docID, "reminder", reminder.toJson());
    } else {
      stor.update(reminder.docID, "reminder", reminder.toJson());
    }
    notifyListeners();
    navigator.back();
  }
}
