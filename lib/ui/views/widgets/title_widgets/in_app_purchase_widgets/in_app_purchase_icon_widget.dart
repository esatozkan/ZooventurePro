import 'package:flutter/material.dart';
import '/data/constants/constants.dart';

class InAppPurchaseIconWidget extends StatelessWidget {
  final String image;
  final String text;
  final Function() onTap;
  final bool isLoading;
  const InAppPurchaseIconWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              isLoading ? "assets/get_firebase_loading.gif" : image,
              height: size.width < 1100 ? 100 : 200,
              width: size.width < 1100 ? 100 : 200,
              fit: BoxFit.cover,
              color:isLoading == true ? itemColor : null,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
                color: itemColor,
                fontSize: MediaQuery.of(context).size.width < 800 ? 15 : 25,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
