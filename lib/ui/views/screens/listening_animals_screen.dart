import '../widgets/title_widgets/title_widget.dart';
import '../../../data/constants/constants.dart';
import '../widgets/on_boarding_control_widget.dart';
import '../widgets/listening_animals_widgets/grid_card_widget.dart';
import 'package:flutter/material.dart';

class ListeningAnimalsScreen extends StatelessWidget {
  const ListeningAnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            screenBackgroundImage(
              "assets/bottom_navbar_icon/animalVoiceIcon.png",
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
              child: GridCardWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
