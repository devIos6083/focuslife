import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_life/models/attendant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 출석 상태를 관리하는 StateNotifier
class AttendanceNotifier extends StateNotifier<AttendanceModel> {
  AttendanceNotifier()
      : super(AttendanceModel(count: 0, isTodayChecked: false)) {
    _loadAttendanceData();
  }

  // 저장된 출석 정보 불러오기
  Future<void> _loadAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt('attendance_count') ?? 0;

    // 오늘 날짜와 마지막 출석 체크 날짜 비교
    final lastCheckDate = prefs.getString('last_check_date');
    final today = DateTime.now().toString().split(' ')[0]; // YYYY-MM-DD 형식

    final isTodayChecked = lastCheckDate == today;

    state = AttendanceModel(count: count, isTodayChecked: isTodayChecked);
  }

  // 출석 정보 저장하기
  Future<void> _saveAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('attendance_count', state.count);

    // 오늘 출석 체크했다면 날짜 저장
    if (state.isTodayChecked) {
      final today = DateTime.now().toString().split(' ')[0]; // YYYY-MM-DD 형식
      await prefs.setString('last_check_date', today);
    }
  }

  // 출석 체크 실행
  Future<bool> checkAttendance() async {
    // 오늘 이미 체크했으면 중복 방지
    if (state.isTodayChecked) {
      return false;
    }

    state = AttendanceModel(
      count: state.count + 1,
      isTodayChecked: true,
    );

    await _saveAttendanceData();
    return true;
  }

  // 출석 횟수 직접 설정 (관리자용 또는 테스트용)
  void setAttendanceCount(int count) {
    state = AttendanceModel(count: count, isTodayChecked: state.isTodayChecked);
    _saveAttendanceData();
  }
}

// 출석 Provider 정의
final attendanceProvider =
    StateNotifierProvider<AttendanceNotifier, AttendanceModel>((ref) {
  return AttendanceNotifier();
});

// AttendanceModel 확장 - 필요한 추가 기능
extension AttendanceModelExtension on AttendanceModel {
  // 현재 출석 상태에 따른 텍스트 반환
  String get statusText =>
      isTodayChecked ? '오늘 출석을 완료했습니다!' : '오늘의 출석체크를 해주세요.';
}
