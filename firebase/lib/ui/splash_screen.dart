import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase/assets/widgets/circles.dart';
import 'package:firebase/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'auth_screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  late double _screenWidth;
  late double _screenHeight;

  Images images = Images();

  @override
  Widget build(BuildContext context) {
    _screenWidth=MediaQuery.of(context).size.width;
    _screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: AnimatedSplashScreen(
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.rightToLeftWithFade,
              animationDuration: const Duration(seconds: 2),
              duration: 6000,
              splashIconSize: 500,
              backgroundColor: Colors.white,
              splash: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text('InnoMerch Hub',style: GoogleFonts.cairo(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  Image(image: AssetImage(images.splashImage),),
                ],
              ),
              nextScreen: LoginScreen(),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(),
              borderRadius: const BorderRadius.only(bottomRight: Radius.elliptical(250, 200)),
            ),
          ),
          Circle(circleSize: 20, circleColor: Colors.orange, circleLeftMargin: 300, circleTopMargin: 600, circleRightMargin: 0, circleBottomMargin: 0,),
          Circle(circleSize: 40, circleColor: Colors.redAccent, circleLeftMargin: 200, circleTopMargin: 600, circleRightMargin: 0, circleBottomMargin: 0,),
          Circle(circleSize: 100, circleColor: Colors.blueGrey, circleLeftMargin: 200, circleTopMargin: 650, circleRightMargin: 0, circleBottomMargin: 0,),
          Circle(circleSize: 50, circleColor: Colors.lightGreenAccent, circleLeftMargin: 300, circleTopMargin: 730, circleRightMargin: 0, circleBottomMargin: 0,),
        ],
      )
    );
  }
}
