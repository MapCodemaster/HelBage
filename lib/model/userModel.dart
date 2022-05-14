class UserModel {
  String email,
      name,
      userID,
      userType,
      address,
      city,
      state,
      gender,
      phoneNo,
      homeNo,
      profilePictureURL;
  int postcode;
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
      

  // UserModel.fromJson(Map<dynamic, dynamic> map) {

  // }

  toJson() {}
}
