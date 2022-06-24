import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:stacked/stacked.dart';

class createCollectionPointScreen extends StatefulWidget {
  const createCollectionPointScreen({Key? key}) : super(key: key);

  @override
  State<createCollectionPointScreen> createState() =>
      _createCollectionPointScreenState();
}

class _createCollectionPointScreenState
    extends State<createCollectionPointScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _address = TextEditingController();
  Validation _validation = Validation();
  GeoPoint? pickLocation;
  String? state;

  bool _loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateCollectionPointViewModel>.reactive(
        viewModelBuilder: () => CreateCollectionPointViewModel(),
        builder: (context, model, child) => Form(
              key: _formkey,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("Add Collection Point"),
                    backgroundColor: logoColor,
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      model
                          .createCollectionPoint(_title.text, _address.text,
                              state, pickLocation, _formkey)
                          .whenComplete(() {
                        setState(() {
                          _loading = false;
                        });
                      });
                    },
                    child: Icon(Icons.save),
                    backgroundColor: logoColor,
                  ),
                  body: _loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Add a bulky waste collection point',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Please provide the following information',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600]),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextinputForm("Title of map marker label",
                                    Colors.blue, Colors.white, _title,
                                    validator: _validation.validateForEmpty,
                                    readonly: false),
                                SizedBox(
                                  height: 10,
                                ),
                                TextinputForm(
                                  "Collection point address",
                                  Colors.blue,
                                  Colors.white,
                                  _address,
                                  validator: _validation.validateForEmpty,
                                  readonly: false,
                                  inputype: TextInputType.multiline,
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                  child: getStateDropDownEnum(
                                      value: state,
                                      onChangeValue: (value) {
                                        state = value;
                                      },
                                      width: MediaQuery.of(context).size.width /
                                          2),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    txtButton("Pick a location", () async {
                                      pickLocation =
                                          await showSimplePickerLocation(
                                              titleWidget: Text(
                                                "Bulky waste collection point",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: logoColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              initZoom: 12,
                                              context: context,
                                              isDismissible: true,
                                              textConfirmPicker: "pick",
                                              initCurrentUserPosition: true);

                                      setState(() {});
                                    },
                                        Colors.green,
                                        150,
                                        50,
                                        TextStyle(
                                          fontSize: 15,
                                        ),
                                        radius: 0),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    pickLocation == null
                                        ? Expanded(
                                            child: Text(
                                                "No location is picked yet."))
                                        : Expanded(
                                            child: Text(
                                                "Latitude: ${pickLocation!.latitude.toString()} \nLongitude:${pickLocation!.longitude.toString()}  "),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _title.clear();
                                      _address.clear();
                                      pickLocation = null;
                                      state = null;
                                      setState(() {});
                                    },
                                    child: Text(
                                      " Reset",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 1.5,
                                          color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.resolveWith(
                                                (states) => 2),
                                        backgroundColor: MaterialStateColor
                                            .resolveWith((states) =>
                                                Color(Colors.blue[900]!.value)),
                                        padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 40),
                                        ),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
            ));
  }
}
