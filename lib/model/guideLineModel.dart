import 'package:helbage/model/tagModel.dart';

class guidelineModel{
  String title;
  String content;
  String author;
  List<tagModel> tag;
  DateTime? datetime;
  String? docid;
  String? userId;
  //constructor for created new guideline
  guidelineModel({required this.title,required this.content,required this.author,required this.tag,this.userId})
  {
    this.datetime=DateTime.now();
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "content": content,
      "author": author,
      "datetime": datetime,
      "tag":converTag(tag),
      "authorId":userId,
    };
  }
  guidelineModel.fromFireStore(
    {
     required this.author,
     required this.content,
     required this.tag,
     required this.title,
     required this.datetime,
     required this.docid
    }
  );
  List<dynamic> converTag(list)
  {
    List<dynamic> tempList=new List.empty(growable: true);
    list.forEach((element){
      tempList.add(element.toString());
    });
    return tempList;
  }
  static List<tagModel> dynamicTagTotagModel(list)
  {
    List<tagModel> tempList=new List.empty(growable: true);
    list.forEach((element){
      tempList.add(new tagModel(name: element.toString()));
    });
    return tempList;
  }
}