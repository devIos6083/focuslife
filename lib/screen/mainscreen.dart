// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:focus_life/models/attendant_model.dart';
import 'package:focus_life/screen/messenger_chat.dart';
import 'package:focus_life/utils/constant.dart';
import 'package:focus_life/widgets/attendant_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:focus_life/models/user_model.dart';
import 'package:focus_life/widgets/user_info_card.dart';
import 'package:focus_life/widgets/law_tip_widget.dart';
import 'package:focus_life/widgets/quick_access_button.dart';
import 'package:focus_life/widgets/guide_banner.dart';

class MainScreen extends StatefulWidget {
  final List<int?> userAnswers;
  final String userName;

  const MainScreen({
    super.key,
    required this.userAnswers,
    required this.userName,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _checkAnimationController;
  late AttendanceModel _attendanceModel;
  late UserModel _userModel;

  @override
  void initState() {
    super.initState();
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _attendanceModel = AttendanceModel(count: 1);
    _userModel = UserModel(
      name: widget.userName,
      answers: widget.userAnswers,
    );
  }

  @override
  void dispose() {
    _checkAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _checkAttendance() {
    setState(() {
      _attendanceModel.checkAttendance();
    });

    // 애니메이션 실행
    _checkAnimationController.forward(from: 0);

    // Snackbar 표시
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
    final List<Widget> pages = [
      _buildHomeTab(),
      MessengerChatScreen(
        userName: "상담사",
        userProfileImage: "img/chat_bot.png",
      ),
      const Center(child: Text('설정 화면')),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Safe',
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.star,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Work',
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: '채팅',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '설정',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보 카드
            UserInfoCard(userModel: _userModel),

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
                print("detail");
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
                          _onItemTapped(1); // 채팅 탭으로 이동
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
              onTapGuide: () {
                print("guide");
              },
              icon: Icons.description,
            ),
          ],
        ),
      ),
    );
  }
}
