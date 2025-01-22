import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:voice_recognizer/Screens/Splash%20Screen/splashScreen_viewModel.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onViewModelReady: (viewModel) => viewModel.StartUp(context),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF2C3E50), 
                  Color(0xFF4B0082), 
                  Color(0xFF8E44AD), 
                
                ],
                center: Alignment(0.8, -0.6),
                radius: 1.2,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.35, 
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Lottie.asset("assets/images/splashScreen.json"),
                      width: 200,
                      height: 200,
                    ),
                  ),

                  
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.63, 
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Speech",
                          style: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 40,
                            color: Colors.white,
                            //letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          "Flow ",
                          style: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 40,
                            color: Color(0xFFE91E63) ,
                            //letterSpacing: 2.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
