class Time {
  int hour;
  int minute;
  Time({required this.hour, required this.minute});

  Time.fromString(
      {required String timeInString, this.hour = 0, this.minute = 0}) {
    this.hour = int.parse(timeInString.split(":")[0]);
    this.minute = int.parse(timeInString.split(":")[1]);
  }
  void addMinute(int minute) {
    this.minute += minute;

    this.hour = this.hour + (this.minute / 60).toInt();

    this.minute = this.minute % 60;
  }

  @override
  String toString() {
    if (minute < 10) {
      return hour.toString() + ":0" + minute.toString();
    } else {
      return hour.toString() + ":" + minute.toString();
    }
  }

  Time clone() {
    return Time(hour: this.hour, minute: this.minute);
  }
}
