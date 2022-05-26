import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  late String url;
  late DateTime dt;
  NewsModel({required this.dt, required this.url});
  NewsModel.fromJson(Map<String, dynamic>? map) {
    Timestamp t = map!["datetime"];
    dt = t.toDate();

    url = map["url"].toString();
  }
  Map<String, dynamic> toJson() {
    return {"datetime": this.dt, "url": this.url};
  }
}
