import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/data/repository/get_information.dart';
import '../../../data/constants/constants.dart';
import '/ui/views/screens/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen.withScreenFunction(
      backgroundColor: itemColor.withOpacity(.8),
      splash: "assets/splash_screen.gif",
      splashIconSize: size.width < 1100 ? 300 : 600,
      screenFunction: () async {
        getInformation(context);
        return const MainScreen();
      },
    );
  }
}
