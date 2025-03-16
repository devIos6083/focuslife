class AttendanceModel {
  int count;
  bool isTodayChecked;

  AttendanceModel({
    this.count = 0,
    this.isTodayChecked = false,
  });

  void checkAttendance() {
    if (!isTodayChecked) {
      isTodayChecked = true;
      count = count + 1;
    }
  }
}
