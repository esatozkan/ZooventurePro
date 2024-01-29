import 'package:flutter/material.dart';
import '/ui/views/widgets/title_widgets/title_widget.dart';
import '/data/services/text_services.dart';
import '../widgets/games_widgets/game_icon_widget.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<GameIconWidget> games = [
      GameIconWidget(
        icon: "assets/games/memory_game_logo.png",
        text1: texts["memory game"].toString(),
        whichFunction: "memoryGame",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_hear_game_logo.png",
        text1: texts["find animal sounds"].toString(),
        whichFunction: "knowWhatHearAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_virtual_image_logo.png",
        text1: texts["find virtual image"].toString(),
        whichFunction: "knowWhatVirtualAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_type_animal_game_logo.png",
        text1: texts["find animal names"].toString(),
        whichFunction: "knowWhatTypeAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/know_what_real_image_logo.png",
        text1: texts["find real image"].toString(),
        whichFunction: "knowWhatRealAnimalScreen",
      ),
      GameIconWidget(
        icon: "assets/games/spelling_bee_game_logo.png",
        text1: texts["spelling bee game"].toString(),
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
          itemCount: isEN ? games.length : games.length - 1,
          itemBuilder: (context, index) => games[index],
        );
      },
    );
  }
}
