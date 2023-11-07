import 'package:provider/provider.dart';
import '../../providers/page_changed_provider.dart';
import '../screens/main_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingControlWidget extends StatefulWidget {
  const OnBoardingControlWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoardingControlWidget> createState() =>
      _OnBoardingControlWidgetState();
}

class _OnBoardingControlWidgetState extends State<OnBoardingControlWidget> {
  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider = Provider.of<PageChangedProvider>(
      context,
    );

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: pageChangedProvider.getPageChanged != 0 ? true : false,
            child: GestureDetector(
              onTap: () async {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                pageChangedProvider.pageChangedFunction(
                    pageChangedProvider.getPageChanged == 1 ? 0 : 1);
              },
              child: Image.asset(
                "assets/bottom_navbar_icon/left_swipe.png",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          Visibility(
            visible: pageChangedProvider.getPageChanged == 2 ? false : true,
            child: GestureDetector(
              onTap: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                 pageChangedProvider.pageChangedFunction(
                    pageChangedProvider.getPageChanged == 0 ? 1 : 2);
              },
              child: Image.asset(
                "assets/bottom_navbar_icon/right_swipe.png",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
