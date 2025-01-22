import 'package:flutter/material.dart';
import 'package:voice_recognizer/Screens/Home%20Screen/homeScreen_view.dart';
import 'package:voice_recognizer/Screens/Splash%20Screen/splashScreen_view.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
    );
  }
}