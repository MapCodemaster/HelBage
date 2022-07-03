import 'package:helbage/model/_model.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Summary/SummaryViewModel.dart';
import 'package:helbage/view/admin/Vehicle/ViewVehicleModel.dart';
import 'package:stacked/stacked.dart';

class SummaryView extends StatefulWidget {
  const SummaryView({super.key});

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  @override
  Widget build(BuildContext) {
    return ViewModelBuilder<SummaryViewModel>.reactive(
        viewModelBuilder: () => SummaryViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: logoColor, title: Text("Summary Detail")),
              body: GridView.count(
                childAspectRatio: (1 / .7),
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(
                          Colors.orangeAccent.value,
                        ),
                        Color(Colors.deepOrange.value)
                      ]),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total number of users:",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(model.returnUser(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(
                          Colors.lightBlue[200]!.value,
                        ),
                        Color(Colors.blueAccent.value)
                      ]),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total number of bulky waste collection points:",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(model.returnCollection(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(
                          Colors.purple[200]!.value,
                        ),
                        Color(logoColor.value)
                      ]),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total number of news:",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(model.returnNews(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(
                          Colors.green[200]!.value,
                        ),
                        Color(Colors.green[800]!.value)
                      ]),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total number of guidelines:",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(model.returnGuidelineCount(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
