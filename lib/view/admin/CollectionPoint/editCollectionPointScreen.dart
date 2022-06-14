import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:stacked/stacked.dart';

class EditCollectionPointScreen extends StatefulWidget {
  const EditCollectionPointScreen({Key? key}) : super(key: key);

  @override
  State<EditCollectionPointScreen> createState() =>
      _EditCollectionPointScreenState();
}

class _EditCollectionPointScreenState extends State<EditCollectionPointScreen> {
  @override
  Validation _validation = new Validation();
  TextEditingController _title = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  GeoPoint? pickLocation;
  String? state;
  bool? _wasButtonClicked;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _loading = false;
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditCollectionPointViewModel>.reactive(
        viewModelBuilder: () => EditCollectionPointViewModel(),
        builder: (context, model, child) {
          if (!model.dataReady) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _title.text = model.data!.title.toString();
            _address.text = model.data!.address.toString();
            String? state = model.data!.state;
            MapController controller = MapController(
                initMapWithUserPosition: false,
                initPosition: GeoPoint(
                    latitude: model.data!.location.latitude,
                    longitude: model.data!.location.longitude));

            List<GeoPoint> collectionpoints = [
              GeoPoint(
                  latitude: model.data!.location.latitude,
                  longitude: model.data!.location.longitude)
            ];

            Widget Map() {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2 / 2,
                child: OSMFlutter(
                  staticPoints: [
                    StaticPositionGeoPoint(
                        model.data!.title,
                        MarkerIcon(
                          iconWidget: Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 100,
                                  color: Colors.green,
                                ),
                                Text(
                                  model.data!.title,
                                  style: TextStyle(
                                      fontSize: 70,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        collectionpoints)
                  ],
                  // onMapIsReady: (isReady) {},
                  onLocationChanged: ((p0) {}),
                  onGeoPointClicked: (geoPoint) async {
                    try {
                      Flushbar? flush;
                      flush = Flushbar<bool>(
                        duration: Duration(seconds: 10),
                        title: model.data!.title,
                        backgroundGradient:
                            LinearGradient(colors: [Colors.blue, Colors.teal]),
                        message: model.data!.address,
                        mainButton: TextButton(
                            onPressed: () {
                              flush!.dismiss(true);
                            },
                            child: Text(
                              "DONE",
                              style: TextStyle(color: Colors.white),
                            )),
                      )..show(context).then((value) {
                          setState(() {
                            _wasButtonClicked = value;
                          });
                        });
                    } catch (e) {}
                  },

                  mapIsLoading: Center(
                    child: CircularProgressIndicator(),
                  ),
                  showDefaultInfoWindow: false,
                  controller: controller,
                  trackMyPosition: false,
                  initZoom: 12,
                  minZoomLevel: 8,
                  maxZoomLevel: 18,
                  stepZoom: 1.0,
                  userLocationMarker: UserLocationMaker(
                    personMarker: MarkerIcon(
                      icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 100,
                      ),
                    ),
                    directionArrowMarker: MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                  roadConfiguration: RoadConfiguration(
                    startIcon: MarkerIcon(
                      icon: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.brown,
                      ),
                    ),
                    roadColor: Colors.yellowAccent,
                  ),
                  markerOption: MarkerOption(
                      defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 100,
                    ),
                  )),
                ),
              );
            }

            return Form(
              key: _formkey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Edit Collection Point"),
                  backgroundColor: logoColor,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    bool validate = model.validate(_formkey);
                    if (validate) {
                      setState(() {
                        _loading = true;
                      });
                      model
                          .editCollectionPoint(
                        _title.text,
                        _address.text,
                        state == null ? model.data!.state : state,
                        pickLocation ??
                            GeoPoint(
                                latitude: model.data!.location.latitude,
                                longitude: model.data!.location.longitude),
                      )
                          .whenComplete(
                        () {
                          setState(() {
                            _loading = false;
                            controller.goToLocation(GeoPoint(
                                latitude: model.data!.location.latitude,
                                longitude: model.data!.location.longitude));
                          });
                        },
                      );
                    }
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
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Map(),
                              SizedBox(
                                height: 10,
                              ),
                              TextinputForm("Title of map marker label",
                                  Colors.blue, Colors.white, _title,
                                  validator: _validation.validateForEmpty,
                                  inputype: TextInputType.text,
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
                                inputype: TextInputType.text,
                                readonly: false,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: getStateDropDownEnum(
                                    value: state,
                                    onChangeValue: (value) {
                                      state = value;
                                    },
                                    width: 200),
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
                                              "Latitude: ${pickLocation!.latitude.toString()} \nLongitude:${pickLocation!.longitude.toString()} "),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
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
                                                  BorderRadius.circular(20)))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            );
          }
        });
  }
}
