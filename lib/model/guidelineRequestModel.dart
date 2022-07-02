import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helbage/model/IModel.dart';
import 'package:helbage/model/guideLineModel.dart';


class guidelineRequestModel extends guidelineModel implements IModel 
{
  bool status=false;
  String? docId;
  guidelineRequestModel({required author,required tag,required title,required content,status=false,this.docId,required authorId}):
  super(author: author,tag:tag,title:title,content: content,userId: authorId);
  
  static guidelineRequestModel FromFireStore(QueryDocumentSnapshot<Map<String,dynamic>> element)
  {
    
    try{
      return guidelineRequestModel(
        author: element['author'], 
        tag: guidelineModel.dynamicTagTotagModel(element['tag']), 
        title: element['title'], 
        content: element['content'],
        status: element['status'],
        docId: element.id,
        authorId: element['authorId']);
    }
    catch(e)
    {
      throw Exception("Data Convertion Error");
    }
    
  }

  @override
  Map<String, dynamic> toFirestore() {
    print(super.author);
    return
    {
      "title":title,
      "author":author,
      "tag":super.converTag(tag),
      "content":content,
      "status":false,
      "authorId":userId,
    };
  }
  guidelineModel  getGuidelineModel()
  {
    return new guidelineModel(title: this.title, content: this.content, author: this.author, tag: this.tag,userId:this.userId);
  }
  
}