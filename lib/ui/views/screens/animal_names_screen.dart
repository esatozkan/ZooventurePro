import '../widgets/title_widgets/title_widget.dart';
import '../widgets/listening_animals_widgets/grid_card_wigdet.dart';
import '/data/constans/constans.dart';
import '../widgets/on_borading_control_widget.dart';
import 'package:flutter/material.dart';

class AnimalNamesScreen extends StatelessWidget {
  const AnimalNamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            screenBackgroundgImage(
              "assets/bottom_navbar_icon/animalsIcon.png",
              height,
              width,
            ),
            const OnBoardingControlWidget(),
            const TitleWidget(),
            const Padding(
              padding: EdgeInsets.only(
                left: 100,
                right: 100,
                top: 100,
              ),
              child: GridCardWigdet(),
            ),
          ],
        ),
      ),
    );
  }
}
