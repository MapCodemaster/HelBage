class guidelineModel{
  String title;
  String content;
  String author;
  DateTime? datetime;
  //constructor for created new guideline
  guidelineModel({required this.title,required this.content,required this.author})
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