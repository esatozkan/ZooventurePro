import '../widgets/title_widgets/title_widget.dart';
import '/data/constans/constans.dart';
import '../widgets/on_borading_control_widget.dart';
import '/ui/views/widgets/listening_animals_widgets/grid_card_wigdet.dart';
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
            screenBackgroundgImage(
              "assets/bottom_navbar_icon/gameScreenIcon.png",
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
