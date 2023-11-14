import '../../../../data/services/application_data_service.dart';
import '../internet_connection_widget.dart';
import '/ui/views/screens/games/know_what_hear_screen.dart';
import '/ui/views/screens/games/know_what_real_animal_screen.dart';
import '/ui/views/screens/games/know_what_type_animal_screen.dart';
import '/ui/views/screens/games/know_what_virtual_animal_screen.dart';
import '../../screens/games/memory_games_screen.dart';
import '../../screens/games/spelling_bee_game_screen.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constants/constants.dart';

class GameIconWidget extends StatefulWidget {
  const GameIconWidget({
    Key? key,
    required this.icon,
    required this.text1,
    required this.whichFunction,
  }) : super(key: key);

  final String icon;
  final String text1;
  final String whichFunction;

  @override
  State<GameIconWidget> createState() => _GameIconWidgetState();
}

class _GameIconWidgetState extends State<GameIconWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Provider.of<AnimalProvider>(context, listen: false)
            .getIsAllInformationDownload) {
          Future.delayed(const Duration(milliseconds: 500));
          if (widget.whichFunction == "memoryGame") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MemoryGamesScreen(),
              ),
            );
            applicationData("Memory Game");
          } else if (widget.whichFunction == "SpellingBeeGame") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SpellingBeeGameScreen(),
              ),
            );
            applicationData("Spelling Bee Game");
          } else if (widget.whichFunction == "knowWhatVirtualAnimalScreen") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KnowWhatVirtualAnimalScreen(),
              ),
            );
            applicationData("Find Virtual Image Game");
          } else if (widget.whichFunction == "knowWhatHearAnimalScreen") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KnowWhatHearAnimalScreen(),
              ),
            );
            applicationData("Know Animal Sounds Game");
          } else if (widget.whichFunction == "knowWhatRealAnimalScreen") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KnowWhatRealAnimalScreen(),
              ),
            );
            applicationData("Find Real Image Game");
          } else if (widget.whichFunction == "knowWhatTypeAnimalScreen") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KnowWhatTypeAnimalScreen(),
              ),
            );
            applicationData("Know Animal Types Game");
          }
        } else {
          showInformationSnackbar(context, "text");
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              widget.icon,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Consumer<AnimalProvider>(
              builder: (context, animalProvider, _) => Text(
                widget.text1,
                style: TextStyle(
                    fontFamily: "displayFont", fontSize: 18, color: itemColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
