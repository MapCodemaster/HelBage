import 'package:helbage/model/tagModel.dart';

class guidelineModel{
  String title;
  String content;
  String author;
  List<tagModel> tag;
  DateTime? datetime;
  //constructor for created new guideline
  guidelineModel({required this.title,required this.content,required this.author,required this.tag})
  {
    this.datetime=DateTime.now();
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "content": content,
      "author": author,
      "datetime": datetime,
    };
  }
}