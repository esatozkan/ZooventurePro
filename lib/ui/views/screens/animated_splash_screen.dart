import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../data/constants/constants.dart';
import '../../../data/services/get_information.dart';
import '/ui/views/screens/main_screen.dart';

final internetConnection = Hive.box("internetConnection");

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      backgroundColor: itemColor.withOpacity(.8),
      splash: "assets/splash_screen.gif",
      splashIconSize: 300,
      screenFunction: () async {
        await getSomeInformation(context);
        internetConnection.put(0, true);
        return const MainScreen();
      },
    );
  }
}
