class VehicleModel {
  late String platNo;
  VehicleModel.fromJson(Map<String, dynamic> map) {
    this.platNo = map["platNo"];
  }
}
