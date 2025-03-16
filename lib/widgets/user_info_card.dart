import 'package:flutter/material.dart';
import 'package:focus_life/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:focus_life/models/user_model.dart';
import 'package:focus_life/widgets/info_item_widget.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel userModel;

  const UserInfoCard({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    // 사용자가 선택한 항목 가져오기
    final String jobType = userModel.jobTypeIndex != null &&
            userModel.jobTypeIndex! < UserInfoConstants.jobTypes.length
        ? UserInfoConstants.jobTypes[userModel.jobTypeIndex!]
        : '정보 없음';

    final String employmentType = userModel.employmentTypeIndex != null &&
            userModel.employmentTypeIndex! <
                UserInfoConstants.employmentTypes.length
        ? UserInfoConstants.employmentTypes[userModel.employmentTypeIndex!]
        : '정보 없음';

    final String issueType = userModel.issueTypeIndex != null &&
            userModel.issueTypeIndex! < UserInfoConstants.issueTypes.length
        ? UserInfoConstants.issueTypes[userModel.issueTypeIndex!]
        : '정보 없음';

    final String attendanceFreq = userModel.attendanceFrequencyIndex != null &&
            userModel.attendanceFrequencyIndex! <
                UserInfoConstants.attendanceFrequency.length
        ? UserInfoConstants
            .attendanceFrequency[userModel.attendanceFrequencyIndex!]
        : '정보 없음';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 사용자 아바타
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 60,
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 사용자 이름
          Text(
            "${userModel.name}님",
            style: GoogleFonts.sora(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 20),

          // 사용자 정보 그리드
          Row(
            children: [
              Expanded(
                child: InfoItemWidget(
                  title: '직종',
                  value: jobType,
                  icon: Icons.work,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoItemWidget(
                  title: '고용 형태',
                  value: employmentType,
                  icon: Icons.business_center,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: InfoItemWidget(
                  title: '관심 문제',
                  value: issueType.length > 15
                      ? '${issueType.substring(0, 15)}...'
                      : issueType,
                  icon: Icons.help_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoItemWidget(
                  title: '출근 빈도',
                  value: attendanceFreq,
                  icon: Icons.calendar_today,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
