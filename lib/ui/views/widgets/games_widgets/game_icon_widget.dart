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
    return IconButton(
      onPressed: () {
        Future.delayed(const Duration(milliseconds: 500));
        if (widget.whichFunction == "memoryGame") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MemoryGamesScreen(),
            ),
          );
        } else if (widget.whichFunction == "SpellingBeeGame") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SpellingBeeGameScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatVirtualAnimalScreen") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatVirtualAnimalScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatHearAnimalScreen") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatHearAnimalScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatRealAnimalScreen") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatRealAnimalScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatTypeAnimalScreen") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatTypeAnimalScreen(),
            ),
          );
        }
      },
      icon: Column(
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
                    fontFamily: "jokerman", fontSize: 18, color: itemColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
