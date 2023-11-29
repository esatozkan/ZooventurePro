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

    List<GameIconWidget> games = [
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
      GameIconWidget(
        icon: "assets/games/know_what_virtual_image_logo.png",
        text1: animalProvider.getUiTexts[12],
        whichFunction: "knowWhatVirtualAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_type_animal_game_logo.png",
        text1: animalProvider.getUiTexts[13],
        whichFunction: "knowWhatTypeAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_real_image_logo.png",
        text1: animalProvider.getUiTexts[10],
        whichFunction: "knowWhatRealAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/spelling_bee_game_logo.png",
        text1: animalProvider.getUiTexts[2],
        whichFunction: "SpellingBeeGame",
      )
    ];

    return Builder(
      builder: (context) {
        return GridView.builder(
          padding: const EdgeInsets.only(top: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
          ),
          itemCount: languageProvider.getLocal == "en"
              ? games.length
              : games.length - 1,
          itemBuilder: (context, index) => games[index],
        );
      },
    );
  }
}
