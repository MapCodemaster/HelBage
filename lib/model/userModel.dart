class UserModel {
  String email,
      name,
      userID,
      userType,
      address,
      city,
      state,
      gender,
      HP,
      HomeNo;
  int postcode;
  UserModel({
    required this.email,
    required this.name,
    required this.userID,
    required this.address,
    required this.userType,
    required this.city,
    required this.postcode,
    required this.state,
    required this.gender,
    required this.HP,
    required this.HomeNo,
  });
  // UserModel.fromJson(Map<dynamic, dynamic> map) {

  // }

  toJson() {}
}
