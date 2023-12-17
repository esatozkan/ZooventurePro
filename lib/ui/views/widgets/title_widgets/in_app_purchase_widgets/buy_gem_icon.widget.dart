// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '/data/constants/constants.dart';

double gemIconWidth = 150;
double gemIconHeight = 135;

class BuyGemIconWidget extends StatelessWidget {
  final String imageAsset;
  final String text;
  final String gemCount;
  final String price;

  const BuyGemIconWidget({
    Key? key,
    required this.imageAsset,
    required this.text,
    required this.gemCount,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gemIconWidth = 150;
    double gemIconHeight = 135;
    return Container(
      height: gemIconHeight,
      width: gemIconWidth,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            height: 55,
            width: gemIconWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 20,
            width: gemIconWidth,
            color: const Color(0xfffea638),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 15,
            width: gemIconWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.diamond,
                  color: itemColor,
                  size: 17,
                ),
                Text(
                  " $gemCount",
                  style: const TextStyle(
                    color: Color(0xff746061),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 25,
            width: gemIconWidth,
            decoration: BoxDecoration(
              color: const Color(0xff7dd507),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
