import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:helbage/model/collectionPointModel.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:helbage/view/resident/CollectionPoint/_resident_Collection_Point.dart';
import 'package:stacked/stacked.dart';

class CollectionPointScreen extends StatefulWidget {
  const CollectionPointScreen({Key? key}) : super(key: key);

  @override
  State<CollectionPointScreen> createState() => _CollectionPointScreenState();
}

class _CollectionPointScreenState extends State<CollectionPointScreen> {
  @override
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  bool? _wasButtonClicked;
  String? _option = "All";
  List<CollectionPointModel>? list = [];
  DraggableScrollableController dragcontroller =
      DraggableScrollableController();
  MapController controller = MapController(
    initMapWithUserPosition: true,
  );
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bulky Waste Collection Point"),
          backgroundColor: logoColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: ViewModelBuilder<CollectionPointViewModel>.reactive(
            viewModelBuilder: () => CollectionPointViewModel(),
            builder: (context, viewmodel, child) {
              if (!viewmodel.dataReady) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<GeoPoint> collectionpoints = [];
                viewmodel.data!.forEach((element) {
                  collectionpoints.add(GeoPoint(
                      latitude: element.location.latitude,
                      longitude: element.location.longitude));
                });
                if (_option == "All") {
                  list = viewmodel.data;
                } else {
                  list = viewmodel.data!.where((e) {
                    return e.state == _option;
                  }).toList();
                }

                Widget Map() {
                  return SizedBox(
                    // height: MediaQuery.of(context).size.height,
                    child: OSMFlutter(
                      staticPoints: [
                        StaticPositionGeoPoint(
                            "Point",
                            MarkerIcon(
                              iconWidget: Container(
                                child: Icon(
                                  Icons.delete,
                                  size: 100,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            collectionpoints)
                      ],
                      // onMapIsReady: (isReady) {},
                      onLocationChanged: ((p0) {}),
                      onGeoPointClicked: (geoPoint) async {
                        CollectionPointModel temp =
                            viewmodel.findPoint(viewmodel.data, geoPoint);
                        Flushbar? flush;
                        flush = Flushbar<bool>(
                          title: temp.title,
                          message: temp.address,
                          duration: Duration(seconds: 10),
                          backgroundGradient: LinearGradient(
                              colors: [Colors.blue, Colors.teal]),
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
                      },

                      mapIsLoading: Center(
                        child: CircularProgressIndicator(),
                      ),
                      showDefaultInfoWindow: true,
                      controller: controller,
                      trackMyPosition: false,
                      initZoom: 14,
                      minZoomLevel: 8,
                      maxZoomLevel: 18,
                      stepZoom: 1.0,
                      userLocationMarker: UserLocationMaker(
                        personMarker: MarkerIcon(
                          icon: Icon(
                            Icons.location_history_rounded,
                            color: Colors.red,
                            size: 150,
                          ),
                        ),
                        directionArrowMarker: MarkerIcon(
                          icon: Icon(
                            Icons.double_arrow,
                            size: 100,
                          ),
                        ),
                      ),
                      roadConfiguration: RoadConfiguration(
                        startIcon: MarkerIcon(
                          icon: Icon(
                            Icons.person,
                            size: 150,
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
                          size: 300,
                        ),
                      )),
                    ),
                  );
                }

                Widget currentlocation() {
                  return Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width - 50,
                          (MediaQuery.of(context).size.height / 2) / 2,
                          0,
                          0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                            ),
                            onPressed: () async {
                              if (!trackingNotifier.value) {
                                await controller.currentLocation();
                                await controller.enableTracking();
                                //await controller.zoom(5.0);
                              } else {
                                await controller.disabledTracking();
                              }
                              trackingNotifier.value = !trackingNotifier.value;
                            },
                            child: ValueListenableBuilder<bool>(
                              valueListenable: trackingNotifier,
                              builder: (ctx, isTracking, _) {
                                if (isTracking) {
                                  return Icon(
                                    Icons.gps_off_sharp,
                                    color: Colors.black,
                                  );
                                }
                                return Icon(
                                  Icons.my_location,
                                  color: Colors.black,
                                );
                              },
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: zoomNotifierActivation,
                            builder: (ctx, isVisible, child) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  onPressed: () async {
                                    await controller.zoomIn();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ));
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: zoomNotifierActivation,
                            builder: (ctx, isVisible, child) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  onPressed: () async {
                                    await controller.zoomOut();
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ));
                            },
                          ),
                        ],
                      ));
                }

                Widget filterButton() {
                  return TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.blue),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () async {
                      _option = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            return FilterDiaolog(
                              option: _option,
                            );
                          }).whenComplete(() {});
                      setState(() {});
                    },
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.filter_alt,
                        size: 25,
                      ),
                    ),
                    label: Text("Filter",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  );
                }

                Widget bottomListSheet() {
                  return DraggableScrollableSheet(
                      initialChildSize: .2,
                      minChildSize: .1,
                      maxChildSize: .6,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                            decoration: BoxDecoration(
                                color: logoColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [filterButton()],
                                  ),
                                  list!.length == 0
                                      ? Center(
                                          child: Text(
                                            "There is no bulky waste collection points yet",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: list!.length,
                                          itemBuilder: ((context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                controller.goToLocation(
                                                    GeoPoint(
                                                        latitude: list![index]
                                                            .location
                                                            .latitude,
                                                        longitude: list![index]
                                                            .location
                                                            .longitude));
                                              },
                                              child: Card(
                                                child: ListTile(
                                                  trailing: IconButton(
                                                      onPressed: () {
                                                        viewmodel.share(
                                                            list![index]
                                                                .location
                                                                .longitude,
                                                            list![index]
                                                                .location
                                                                .latitude,
                                                            list![index].title);
                                                      },
                                                      icon: Icon(Icons.share)),
                                                  subtitle: Text(
                                                      list![index].address),
                                                  title:
                                                      Text(list![index].title),
                                                ),
                                              ),
                                            );
                                          })),
                                ],
                              ),
                            ));
                      });
                }

                return Container(
                  child: Stack(
                    children: [Map(), currentlocation(), bottomListSheet()],
                  ),
                );
              }
            }));
  }
}
