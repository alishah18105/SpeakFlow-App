import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:voice_recognizer/Screens/Home%20Screen/homeScreen_view.dart';

class SplashScreenViewModel extends BaseViewModel {

  void StartUp(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreenView()));
    });
  }
}
