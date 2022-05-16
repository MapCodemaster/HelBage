class UserModel {
  late String email,
      name,
      userID,
      userType,
      address,
      city,
      state,
      gender,
      phoneNo,
      homeNo,
      profilePictureURL,
      postcode;
  UserModel(
      {required this.email,
      required this.name,
      required this.userID,
      required this.address,
      required this.userType,
      required this.city,
      required this.postcode,
      required this.state,
      required this.gender,
      required this.phoneNo,
      required this.homeNo,
      required this.profilePictureURL});

  UserModel.fromJson(Map<String, dynamic>? map) {
    this.email = map!["email"];
    this.address = map["address"];
    this.city = map["city"];
    this.gender = map["gender"];
    this.homeNo = map["homeNo"];
    this.phoneNo = map["phoneNo"];
    this.name = map["name"];
    this.postcode = map["postcode"];
    this.state = map["state"];
    this.userType = map["userType"];
    this.userID = map["userID"];
    this.profilePictureURL = map["profilePictureURL"];
  }
  Map toJson()=>{};
  
  Map<String, dynamic> toFirestore(){
    return{
    "email": email,
    "name": name,
    "userID": userID,
    "address": address,
    "userType": userType,
    "city": city,
    "postcode": postcode,
    "state": state,
    "gender": gender,
    "phoneNo": phoneNo,
    "homeNo": homeNo,
    "profilePictureURL": profilePictureURL
  };}
}
