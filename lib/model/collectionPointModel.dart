import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionPointModel {
  late String title, address, state, id;
  late GeoPoint location;
  CollectionPointModel(
      String title, String address, String state, double lat, double long) {
    this.title = title;
    this.state = state;
    this.address = address;
    this.location = GeoPoint(lat, long);
  }
  CollectionPointModel.fromJson(Map<String, dynamic>? map, String id) {
    this.title = map!["title"];
    this.address = map["address"];
    this.state = map["state"];
    this.location = map["location"];
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'address': this.address,
      'state': this.state,
      'location': this.location,
    };
  }
}
