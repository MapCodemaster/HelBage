import 'package:helbage/model/_model.dart';

abstract class PushNotificationService {
  void createNotification(int id, pathModel object, ReminderModel reminder);
}
