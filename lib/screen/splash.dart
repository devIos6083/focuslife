// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_life/screen/mainscreen.dart';
import 'package:focus_life/screen/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:focus_life/screen/mainscreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // 제목 (Focus Life)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Focus 텍스트
                  Text(
                    'Safe',
                    style: GoogleFonts.sora(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F414E),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // SVG 아이콘
                  SvgPicture.asset(
                    'img/star.svg',
                    width: 30,
                    height: 30,
                    color: Color(0xFF8589EB),
                  ),
                  const SizedBox(width: 10),
                  // Life 텍스트
                  Text(
                    'Work',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F414E),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 70,
              ),

              // 메인 이미지
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 12,
                  bottom: 12,
                ),
                child: Image.asset(
                  'img/worker.jpg',
                  width: size.width * 0.8,
                  height: 300,
                ),
              ),

              const SizedBox(height: 30),

              // 핵심 문장 (Bold)
              Text(
                "Know Your Rights, Work Smarter",
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F414E),
                ),
              ),

              const SizedBox(height: 20),

              // 부가 설명 (Light)

              Text(
                'Find laws and regulations instantly.\n Work with confidence.',
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFFA1A4B2),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              // Get Started 버튼
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnboardingQuestions()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8E97FD),
                    foregroundColor: Colors.white,
                    minimumSize: Size(size.width * 0.8, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
