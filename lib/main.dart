import 'package:flutter/material.dart';
import 'package:focus_life/screen/homescreen.dart';
import 'package:focus_life/screen/splash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MyWidget(),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
