class AttendanceModel {
  final int count;
  final bool isTodayChecked;

  AttendanceModel({
    this.count = 0,
    this.isTodayChecked = false,
  });

  // copyWith 메서드 추가
  AttendanceModel copyWith({
    int? count,
    bool? isTodayChecked,
  }) {
    return AttendanceModel(
      count: count ?? this.count,
      isTodayChecked: isTodayChecked ?? this.isTodayChecked,
    );
  }
}
