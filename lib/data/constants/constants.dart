import 'package:flutter/material.dart';

Color itemColor = Colors.pink;
Color giftWidgetItemColor = Colors.grey.shade300;

Image screenBackgroundImage(String image, double height, double width) {
  Image screenBgImage = Image.asset(
    image,
    height: height,
    width: width,
    color: Colors.grey.withOpacity(.2),
  );
  return screenBgImage;
}

ThemeData spellingBeeGameThemeData = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: "partyConfetti",
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);
