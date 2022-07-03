import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/pushNotificationService.dart';

class LocalNotification implements PushNotificationService {
  void createNotification(int id, pathModel object, ReminderModel reminder) {
    AwesomeNotifications().cancel(id).whenComplete(() {
      print("cancel");
    });
    var startime = object.getStartTime();
    var endtime = object.getEndTime();
    var current = DateTime.now();

    int first = reminder.schedule.indexOf("/");
    int second = reminder.schedule.indexOf("/", first + 1);
    int last = reminder.schedule.lastIndexOf("/");
    String state = reminder.schedule.substring(first + 1, second);
    String path = reminder.schedule.substring(last + 1);
    String title = path + " (State: " + state + ")";
    String? startlocation = object.startLocation;
    String? endlocation = object.endLocation;
    String? body = startlocation! + " to " + endlocation!;

    AwesomeNotifications().createNotification(
        schedule:
            NotificationCalendar(hour: startime!.hour, minute: startime.minute),
        content: NotificationContent(
            id: id, channelKey: 'scheduled_channel', title: title, body: body));
  }
}
