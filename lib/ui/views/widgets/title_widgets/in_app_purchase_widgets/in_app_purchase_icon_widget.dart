// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/ui/views/widgets/title_widgets/in_app_purchase_widgets/subscribe_remove_ad_widget.dart';
import '../../../../../data/constants/constants.dart';

class PurchaseIconWidget extends StatefulWidget {
  final String icon;
  final String text;
  final String whichFunction;
  const PurchaseIconWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.whichFunction,
  }) : super(key: key);

  @override
  State<PurchaseIconWidget> createState() => _PurchaseIconWidget();
}

class _PurchaseIconWidget extends State<PurchaseIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          if (widget.whichFunction == "removeAds") {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown
            ]).then((value) {
              subscribeRemoveAdWidget(context);
            });
          } else if (widget.whichFunction == "buy_24_animals") {
          }
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.icon,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontFamily: "displayFont",
                  fontSize: 20,
                  // fontWeight: FontWeight.w400,
                  color: itemColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
