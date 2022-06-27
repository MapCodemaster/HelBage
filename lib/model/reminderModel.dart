class ReminderModel {
  late String userID, schedule, docID;
  late bool status;

  ReminderModel(
      {required this.userID,
      required this.schedule,
      required this.status,
      required this.docID});
  ReminderModel.fromJson(Map<String, dynamic>? map) {
    this.userID = map!["userID"];
    this.schedule = map["schedule"];
    this.status = map["status"];
    this.docID = map["docID"];
  }
  Map<String, dynamic> toJson() {
    return {
      "userID": this.userID,
      "schedule": this.schedule,
      "status": this.status,
      "docID": this.docID
    };
  }
}
