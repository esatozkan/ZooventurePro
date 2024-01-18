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

    final Size size = MediaQuery.of(context).size;

    List<GameIconWidget> games = [
      GameIconWidget(
        icon: "assets/games/memory_game_logo.png",
        text1: animalProvider.getUiTexts["memory game"],
        whichFunction: "memoryGame",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_hear_game_logo.png",
        text1: animalProvider.getUiTexts["find animal sounds"],
        whichFunction: "knowWhatHearAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_virtual_image_logo.png",
        text1: animalProvider.getUiTexts["find virtual image"],
        whichFunction: "knowWhatVirtualAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_type_animal_game_logo.png",
        text1: animalProvider.getUiTexts["find animal names"],
        whichFunction: "knowWhatTypeAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_real_image_logo.png",
        text1: animalProvider.getUiTexts["find real image"],
        whichFunction: "knowWhatRealAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/spelling_bee_game_logo.png",
        text1: animalProvider.getUiTexts["spelling bee game"],
        whichFunction: "SpellingBeeGame",
      )
    ];

    return Builder(
      builder: (context) {
        return GridView.builder(
          padding: EdgeInsets.only(top: size.width < 1100 ? 10 : 15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: size.width < 1100 ? 200 : 350,
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
