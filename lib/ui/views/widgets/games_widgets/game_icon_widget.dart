import '/ui/providers/page_changed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constants/constants.dart';

class GameIconWidget extends StatefulWidget {
  const GameIconWidget({
    Key? key,
    required this.icon,
    required this.text1,
    required this.whichFunction,
  }) : super(key: key);

  final String icon;
  final String text1;
  final String whichFunction;

  @override
  State<GameIconWidget> createState() => _GameIconWidgetState();
}

class _GameIconWidgetState extends State<GameIconWidget> {
  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          if (widget.whichFunction == "memoryGame") {
            pageChangedProvider.pageChangedFunction(7);
          } else if (widget.whichFunction == "SpellingBeeGame") {
            pageChangedProvider.pageChangedFunction(8);
          } else if (widget.whichFunction == "knowWhatVirtualAnimalScreen") {
            pageChangedProvider.pageChangedFunction(6);
          } else if (widget.whichFunction == "knowWhatHearAnimalScreen") {
            pageChangedProvider.pageChangedFunction(3);
          } else if (widget.whichFunction == "knowWhatRealAnimalScreen") {
            pageChangedProvider.pageChangedFunction(4);
          } else if (widget.whichFunction == "knowWhatTypeAnimalScreen") {
            pageChangedProvider.pageChangedFunction(5);
          }
        });
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              widget.icon,
              height: size.width < 1100 ? 120 : 220,
              width: size.width < 1100 ? 120 : 220,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width < 110 ? 5 : 10),
            child: Text(
              widget.text1,
              style: TextStyle(
                  fontFamily: "displayFont",
                  fontSize: size.width < 1100 ? 18 : 34,
                  color: itemColor),
            ),
          ),
        ],
      ),
    );
  }
}
