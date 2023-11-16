import 'package:provider/provider.dart';
import '/ui/providers/language_provider.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/games_widgets/game_icon_widget.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider = Provider.of(context, listen: false);
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    return Builder(
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GameIconWidget(
                        icon: "assets/games/memory_game_logo.png",
                        text1: animalProvider.getUiTexts[1],
                        whichFunction: "memoryGame",
                      ),
                      GameIconWidget(
                        icon: "assets/games/know_what_hear_game_logo.png",
                        text1: animalProvider.getUiTexts[11],
                        whichFunction: "knowWhatHearAnimalScreen",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GameIconWidget(
                        icon: "assets/games/know_what_virtual_image_logo.png",
                        text1: animalProvider.getUiTexts[12],
                        whichFunction: "knowWhatVirtualAnimalScreen",
                      ),
                      GameIconWidget(
                        icon:
                            "assets/games/know_what_type_animal_game_logo.png",
                        text1: animalProvider.getUiTexts[13],
                        whichFunction: "knowWhatTypeAnimalScreen",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GameIconWidget(
                        icon: "assets/games/know_what_real_image_logo.png",
                        text1: animalProvider.getUiTexts[10],
                        whichFunction: "knowWhatRealAnimalScreen",
                      ),
                      languageProvider.getLocal == "en"
                          ? GameIconWidget(
                              icon: "assets/games/spelling_bee_game_logo.png",
                              text1: animalProvider.getUiTexts[2],
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
        );
      },
    );
  }
}
