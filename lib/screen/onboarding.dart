// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:focus_life/screen/mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingQuestions extends StatefulWidget {
  const OnboardingQuestions({super.key});

  @override
  State<OnboardingQuestions> createState() => _OnboardingQuestionsState();
}

class _OnboardingQuestionsState extends State<OnboardingQuestions> {
  // 현재 질문 인덱스
  int currentQuestionIndex = 0;

  // 각 질문에 대한 선택된 답변 인덱스 저장
  List<int?> selectedAnswers = [null, null, null];

  // 질문 목록
  final List<Map<String, dynamic>> questions = [
    {
      'question': '어떤 업종에서 일하고 계신가요?',
      'options': [
        '🚚 운수업 (택배, 배달, 트럭 운전 등)',
        '🏭 제조업 (공장, 생산직, 건설 등)',
        '🏢 사무직 (일반 회사원, 프리랜서 등)',
        '🍴 서비스업 (요식업, 판매직, 고객 서비스 등)',
        '⚙️ 기타'
      ]
    },
    {
      'question': '어떤 형태로 근무하고 계신가요?',
      'options': [
        '🕒 정규직 (풀타임 근무)',
        '⏳ 계약직 (단기 계약, 프로젝트 근무)',
        '🏃 프리랜서 / 자영업 (개인 사업, 자유 근무)',
        '🎯 파트타임 / 아르바이트'
      ]
    },
    {
      'question': '현재 어떤 문제로 고민 중이신가요?',
      'options': [
        '❌ 급여 미지급 / 임금 체불',
        '⏳ 초과 근무 / 연장 근무 문제',
        '⚖️ 부당 해고 / 계약 종료 문제',
        '🏥 산업재해 / 안전 문제',
        '🤷 아직 문제는 없고, 정보만 보고 싶어요!'
      ]
    },
  ];

  // 다음 질문으로 넘어가기
  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1 &&
        selectedAnswers[currentQuestionIndex] != null) {
      setState(() {
        currentQuestionIndex++;
      });
    } else if (currentQuestionIndex == questions.length - 1 &&
        selectedAnswers[currentQuestionIndex] != null) {
      // 모든 질문 완료 후 다음 화면으로 이동
      // TODO: 채팅 화면으로 이동하는 로직 추가
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            userAnswers: selectedAnswers,
            userName: "강홍규",
          ),
        ),
      );
    }
  }

  // 특정 질문의 특정 답변 선택
  void selectAnswer(int questionIndex, int answerIndex) {
    setState(() {
      selectedAnswers[questionIndex] = answerIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '기본 정보',
          style: GoogleFonts.sora(
            color: Color(0xFF3F414E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 진행 바
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: List.generate(
                  questions.length,
                  (index) => Expanded(
                    child: Container(
                      height: 6,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= currentQuestionIndex
                            ? Color(0xFF8E97FD)
                            : Color(0xFFE6E7F2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 질문 및 옵션
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 질문
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15), // 불투명도 증가
                            blurRadius: 12,
                            spreadRadius: 1,
                            offset: Offset(0, 3), // 아래쪽 오프셋 증가
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        questions[currentQuestionIndex]['question'],
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3F414E),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    // 답변 옵션들
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            questions[currentQuestionIndex]['options'].length,
                        itemBuilder: (context, index) {
                          final bool isSelected =
                              selectedAnswers[currentQuestionIndex] == index;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () =>
                                  selectAnswer(currentQuestionIndex, index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color(0xFFE6F9E7)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? Color(0xFF4CAF50)
                                        : Color(0xFFE6E7F2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        questions[currentQuestionIndex]
                                            ['options'][index],
                                        style: GoogleFonts.sora(
                                          fontSize: 14,
                                          color: Color(0xFF3F414E),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Color(0xFF4CAF50)
                                            : Colors.white,
                                        border: Border.all(
                                          color: isSelected
                                              ? Color(0xFF4CAF50)
                                              : Color(0xFFE6E7F2),
                                          width: 1,
                                        ),
                                      ),
                                      child: isSelected
                                          ? Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 다음 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: ElevatedButton(
                onPressed: selectedAnswers[currentQuestionIndex] != null
                    ? goToNextQuestion
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8E97FD),
                  disabledBackgroundColor: Color(0xFFCCCEE5),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Next',
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
