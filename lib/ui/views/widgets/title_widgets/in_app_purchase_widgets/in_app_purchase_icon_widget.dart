// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
    return IconButton(
   
      onPressed: () {},
      icon: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.icon,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: "jokerman",
                fontSize: 18,
                color: itemColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
