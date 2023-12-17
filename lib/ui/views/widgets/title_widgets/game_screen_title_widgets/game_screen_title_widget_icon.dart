// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/lives_provider.dart';

class GameScreenTitleWidgetIcon extends StatelessWidget {
  final Icon icon;
  final String text;
  final bool isChance;
  final Color color;
  const GameScreenTitleWidgetIcon({
    Key? key,
    required this.icon,
    required this.text,
    this.isChance = false,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width < 1100 ? 30 : 50,
      width: size.width < 1100 ? 100 : 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              icon,
              isChance == true
                  ? Text(
                      Provider.of<LivesProvider>(context).getLive.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 1100 ? 18 : 30),
                    )
                  : const Text(""),
            ],
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width < 1100 ? 16 : 25),
          )
        ],
      ),
    );
  }
}
