import 'package:flutter/material.dart';
import '/data/constans/constans.dart';
import '../../../../../data/services/language_service.dart';

Future loadingWidget(context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          color: Colors.transparent,
          child: Image.asset(
            "assets/loading.gif",
            color: itemColor,
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 3,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );

  await chanceLocal(context);

  Navigator.of(context).pop();
}
