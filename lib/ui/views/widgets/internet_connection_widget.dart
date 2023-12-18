import 'package:flutter/material.dart';
import '/data/constants/constants.dart';

void showInformationSnackbar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: itemColor,
      content: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: "displayFont",
            fontSize: 23,
          ),
        ),
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}
