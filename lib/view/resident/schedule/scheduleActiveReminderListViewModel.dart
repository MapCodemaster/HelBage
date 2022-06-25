import 'package:helbage/app/_route.dart';
import 'package:helbage/constant/State.dart';
import 'package:helbage/model/reminderModel.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/model/_model.dart';

class ScheduleActiveReminderListViewModel
    extends StreamViewModel<List<ReminderModel>> {
  final _storage = locator<storage_service>();
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();
  Stream<List<ReminderModel>> get stream => fetchReminderList();

  Stream<List<ReminderModel>> fetchReminderList() {
    return _storage.readCollectionAsStream("reminder").map((event) => event.docs
        .map((e) => ReminderModel.fromJson(e.data()))
        .toList()
        .where((element) => element.userID == _auth.getUID() && element.status)
        .toList());
  }

  Future<scheduleModel> fetch(String state, String path) async {
    var temp = await _storage.read("schedule/" + state + "/Path", path);
    MalaysiaState s = getState(state);
    return scheduleModel(
        s,
        pathModel.fromFireStore(
            startTimeString: temp['StartTime'],
            locationList: temp['locationList'],
            durationList: temp['durationList'],
            vehicle: temp['vehicle'],
            endTimeString: temp['EndTime']),
        temp.id);
  }
}
