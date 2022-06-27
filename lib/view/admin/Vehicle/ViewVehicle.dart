import 'package:helbage/model/_model.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Vehicle/ViewVehicleModel.dart';
import 'package:stacked/stacked.dart';

class ViewVehicle extends StatefulWidget{
  const ViewVehicle({super.key});

  @override
    State<ViewVehicle> createState() => _ViewVehicleState();
}

class _ViewVehicleState extends State<ViewVehicle>{
  
  @override
  Widget build(BuildContext){
    return ViewModelBuilder<ViewVehicleModel>.reactive(viewModelBuilder: () => ViewVehicleModel(),
    builder: (context, model, child) => Scaffold(
      appBar: AppBar(
        backgroundColor: logoColor,
        title: Text("Vehicle Detail")
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
            itemCount: model.vList.length,
            itemBuilder: (context, index)
            {
              return Container(
                padding: const EdgeInsets.all(8.0),
                height: 100,
                width: double.infinity,margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Garbage truck.jpg"),
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft
                  ),
                ),
                child: Center(
                  child: Text(model.vList[index].platNo),
                  ),
              );
            },),
        ),
      ),
    ));
  }
}