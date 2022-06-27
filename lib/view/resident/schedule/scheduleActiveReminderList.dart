import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/resident/schedule/scheduleActiveReminderListViewModel.dart';
import 'package:helbage/view/resident/schedule/scheduleReminderDialog.dart';
import 'package:stacked/stacked.dart';

class ScheduleActiveReminderList extends StatelessWidget {
  const ScheduleActiveReminderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleActiveReminderListViewModel>.reactive(
        viewModelBuilder: () => ScheduleActiveReminderListViewModel(),
        builder: (context, model, child) {
          if (model.dataReady) {
            model.data!.sort((a, b) => a.schedule.compareTo(b.schedule));
            return Scaffold(
              appBar: AppBar(
                title: Text("Active Reminder"),
                backgroundColor: logoColor,
              ),
              body: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.data!.length,
                    itemBuilder: (context, index) {
                      int first = model.data![index].schedule.indexOf("/");
                      int second =
                          model.data![index].schedule.indexOf("/", first + 1);
                      int last = model.data![index].schedule.lastIndexOf("/");
                      String state = model.data![index].schedule
                          .substring(first + 1, second);
                      String path =
                          model.data![index].schedule.substring(last + 1);
                      return InkWell(
                          onTap: () async {
                            var obj = await model.fetch(state, path);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ScheduleReminderDialog(
                                      reminder: model.data![index],
                                      schedule: obj);
                                });
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("${state} - ${path}"),
                              trailing: Icon(Icons.notifications_on),
                            ),
                          ));
                    }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
