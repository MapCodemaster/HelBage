import 'package:helbage/model/reminderModel.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/resident/schedule/_schedule.dart';
import 'package:stacked/stacked.dart';

class ScheduleReminderDialog extends StatefulWidget {
  final ReminderModel reminder;
  final scheduleModel schedule;
  const ScheduleReminderDialog(
      {Key? key, required this.reminder, required this.schedule})
      : super(key: key);

  @override
  State<ScheduleReminderDialog> createState() => _ScheduleReminderDialogState();
}

class _ScheduleReminderDialogState extends State<ScheduleReminderDialog> {
  bool _isSwitched = false;
  void initState() {
    _isSwitched = widget.reminder.status;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleReminderDialogViewModel>.reactive(
      builder: ((context, model, child) {
        return AlertDialog(
          title: Text(
            "Set Schedule Reminder",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                model.closeDialog();
              },
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                model.save(widget.reminder, _isSwitched, widget.schedule);
              },
              child: Text('SAVE'),
            ),
          ],
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reminder : ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
              ),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        );
      }),
      viewModelBuilder: () => ScheduleReminderDialogViewModel(),
    );
  }
}
