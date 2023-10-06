import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import '../../../data/constans/constans.dart';
import '../widgets/on_borading_control_widget.dart';
import '../widgets/games_widgets/game_icon_widget.dart';
import '../widgets/title_widgets/title_widget.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider = Provider.of(context);

    if (animalProvider.changeText) {
      setState(
        () {
          animalProvider.getUiTexts[5] = animalProvider.getUiTexts[5];
          animalProvider.getUiTexts[6] = animalProvider.getUiTexts[6];
          animalProvider.getUiTexts[7] = animalProvider.getUiTexts[7];
          animalProvider.getUiTexts[8] = animalProvider.getUiTexts[8];
        },
      );

      animalProvider.falseTextFunction();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<GameIconWidget> games = [
      GameIconWidget(
        icon: "assets/games/know_what_real_image_logo.png",
        text1: animalProvider.getUiTexts[5],
        whichFonction: "knowWhatVirtualAnimalImage",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_hear_game_logo.png",
        text1: animalProvider.getUiTexts[6],
        whichFonction: "knowWhatHear",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_virtual_image_logo.png",
        text1: animalProvider.getUiTexts[7],
        whichFonction: "knowWhatRealImage",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_type_animal_game_logo.png",
        text1: animalProvider.getUiTexts[8],
        whichFonction: "knowWhatTypeAnimal",
      ),
    ];
    return Builder(
      builder: (context) {
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                    top: 100,
                    bottom: 50,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: games.length,
                    itemBuilder: (BuildContext context, index) {
                      return games[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
