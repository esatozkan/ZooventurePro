import 'package:provider/provider.dart';
import '/ui/providers/language_provider.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import '../../../data/constants/constants.dart';
import '../widgets/on_boarding_control_widget.dart';
import '../widgets/games_widgets/game_icon_widget.dart';
import '../widgets/title_widgets/title_widget.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider = Provider.of(context, listen: false);
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                screenBackgroundImage(
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
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const GameIconWidget(
                                icon: "assets/games/memory_game_logo.png",
                                text1: "Memory",
                                whichFunction: "memoryGame",
                              ),
                              GameIconWidget(
                                icon:
                                    "assets/games/know_what_hear_game_logo.png",
                                text1: animalProvider.getUiTexts[6],
                                whichFunction: "knowWhatHearAnimalScreen",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GameIconWidget(
                                icon:
                                    "assets/games/know_what_virtual_image_logo.png",
                                text1: animalProvider.getUiTexts[7],
                                whichFunction: "knowWhatVirtualAnimalScreen",
                              ),
                              GameIconWidget(
                                icon:
                                    "assets/games/know_what_type_animal_game_logo.png",
                                text1: animalProvider.getUiTexts[8],
                                whichFunction: "knowWhatTypeAnimalScreen",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GameIconWidget(
                                icon:
                                    "assets/games/know_what_real_image_logo.png",
                                text1: animalProvider.getUiTexts[5],
                                whichFunction: "knowWhatRealAnimalScreen",
                              ),
                              languageProvider.getLocal == "en"
                                  ? const GameIconWidget(
                                      icon:
                                          "assets/games/spelling_bee_game_logo.png",
                                      text1: "Spelling Bee",
                                      whichFunction: "SpellingBeeGame",
                                    )
                                  : Container(
                                      height: 150,
                                      width: 150,
                                      color: Colors.transparent,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
