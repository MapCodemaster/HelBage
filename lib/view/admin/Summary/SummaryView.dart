import 'package:helbage/model/_model.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Summary/SummaryViewModel.dart';
import 'package:helbage/view/admin/Vehicle/ViewVehicleModel.dart';
import 'package:stacked/stacked.dart';

class SummaryView extends StatefulWidget{
  const SummaryView({super.key});

  @override
    State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView>{
  
  @override
  Widget build(BuildContext){
    return ViewModelBuilder<SummaryViewModel>.reactive(viewModelBuilder: () => SummaryViewModel(),
    builder: (context, model, child) => Scaffold(
      appBar: AppBar(
        backgroundColor: logoColor,
        title: Text("Summary Detail")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: 
            Center(
              child: Text("The total user is:" + model.returnUser(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              )
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Center(
            child: Text("The total collection point is:" + model.returnCollection(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
        ),
        ),
        SizedBox(
            height: 20,
          ),
          Expanded(
            child: Center(
            child: Text("The total newst is:" + model.returnNews(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
        ),
        ),
        ]
      ),
    ));
  }
}