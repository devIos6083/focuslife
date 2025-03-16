import 'package:flutter/material.dart';
import 'package:focus_life/models/attendant_model.dart';
import 'package:focus_life/utils/constant.dart';
import 'package:focus_life/widgets/attendant_widget.dart';
import 'package:focus_life/widgets/guide_banner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:focus_life/models/user_model.dart';

import 'package:focus_life/widgets/user_info_card.dart';

import 'package:focus_life/widgets/law_tip_widget.dart';
import 'package:focus_life/widgets/quick_access_button.dart';

class HomeTab extends StatefulWidget {
  final UserModel user;
  final Function(int) onNavigateToTab;

  const HomeTab({
    super.key,
    required this.user,
    required this.onNavigateToTab,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late AttendanceModel _attendanceModel;
  late AnimationController _checkAnimationController;

  @override
  void initState() {
    super.initState();
    // Initialize with count 0 to fix the problem where it was showing 1 at start
    _attendanceModel = AttendanceModel(count: 0, isTodayChecked: false);
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _checkAnimationController.dispose();
    super.dispose();
  }

  void _checkAttendance() {
    // This properly increments by 1 now
    setState(() {
      _attendanceModel.checkAttendance();
    });

    // Animate the check mark
    _checkAnimationController.forward(from: 0);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '오늘 하루도 화이팅하시기 바랍니다!',
          style: GoogleFonts.sora(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보 카드
            UserInfoCard(userModel: widget.user),

            const SizedBox(height: 30),

            // 출석 체크 섹션
            AttendanceWidget(
              attendance: _attendanceModel,
              onCheckAttendance: _checkAttendance,
              animationController: _checkAnimationController,
            ),

            const SizedBox(height: 30),

            // 법률 정보 팁 섹션
            LawTipWidget(
              title: '오늘의 노동법 팁',
              content:
                  '근로기준법 제54조에 따라 사용자는 근로시간이 4시간인 경우 30분 이상, 8시간인 경우 1시간 이상의 휴게시간을 근로시간 도중에 주어야 합니다.',
              onTapDetail: () {
                // 자세히 보기 동작 구현
              },
            ),

            const SizedBox(height: 30),

            // 빠른 액세스 버튼 섹션
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '빠른 액세스',
                  style: GoogleFonts.sora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: QuickAccessButton(
                        title: '법률 정보',
                        icon: Icons.book,
                        color: AppColors.primary,
                        onTap: () {
                          // 법률 정보 화면으로 이동
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: QuickAccessButton(
                        title: '상담하기',
                        icon: Icons.chat_bubble,
                        color: AppColors.accent,
                        onTap: () {
                          widget.onNavigateToTab(1); // 채팅 탭으로 이동
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: QuickAccessButton(
                        title: '문서 작성',
                        icon: Icons.description,
                        color: AppColors.error,
                        onTap: () {
                          // 문서 작성 화면으로 이동
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: QuickAccessButton(
                        title: '도움 요청',
                        icon: Icons.help,
                        color: AppColors.warning,
                        onTap: () {
                          // 도움 요청 화면으로 이동
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 알림 섹션
            GuideBannerWidget(
              title: '근로 계약서 작성 방법',
              description: '근로 계약서 작성 시 꼭 확인해야 할 사항들을 알려드립니다.',
              icon: Icons.description,
              onTapGuide: () {
                // 가이드 보기 동작 구현
              },
            ),
          ],
        ),
      ),
    );
  }
}
