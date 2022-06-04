import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  late String url, documentID;
  late DateTime dt;
  NewsModel({required this.dt, required this.url, required this.documentID});
  NewsModel.fromJson(Map<String, dynamic>? map, String docID) {
    Timestamp t = map!["datetime"];
    dt = t.toDate();
    this.documentID = docID;

    url = map["url"].toString();
  }
  Map<String, dynamic> toJson() {
    return {"datetime": this.dt, "url": this.url};
  }
}
