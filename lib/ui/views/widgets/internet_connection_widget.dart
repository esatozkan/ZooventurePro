import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/data/constants/constants.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';

void showInternetConnectionSnackbar(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: itemColor,
      content: Center(
        child: Text(
          Provider.of<AnimalProvider>(context, listen: false).getUiTexts[14],
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
