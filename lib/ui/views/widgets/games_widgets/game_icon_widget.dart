import 'dart:math';
import '/ui/views/screens/games/memory_games_screen.dart';
import '../../screens/spelling_bee_game_screen.dart';
import '../../../../data/services/application_data_service.dart';
import '/ui/providers/animal_provider.dart';
import '/ui/views/screens/games/know_what_real_animal_screen.dart';
import '../../screens/games/know_what_virtual_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/repository/generate_question.dart';
import '../../../providers/games_control_provider.dart';
import '../../../../data/constants/constants.dart';
import '/ui/views/screens/games/know_what_hear_screen.dart';
import '../../screens/games/know_what_type_animal_screen.dart';

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
        if (widget.whichFunction == "knowWhatTypeAnimal") {
          applicationData("Click Know Animal Types");
          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionSkor();
          typeQuestions.shuffle(Random());
          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionIndex();
          for (int i = 0; i < 4; i++) {
            typeQuestions[
                    Provider.of<GamesControlProvider>(context, listen: false)
                        .getVoiceGameQuestionIndex]
                .option[i]
                .isVisible = false;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatTypeAnimalScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatHear") {
          applicationData("Click Know Animal Sounds");

          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionSkor();
          questions.shuffle(Random());
          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionIndex();
          for (int i = 0; i < 4; i++) {
            questions[Provider.of<GamesControlProvider>(context, listen: false)
                    .getVoiceGameQuestionIndex]
                .option[i]
                .isVisible = false;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatHearScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatRealImage") {
          applicationData("Click Find Virtual Image");

          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionSkor();
          realImageQuestions.shuffle(Random());
          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionIndex();
          for (int i = 0; i < 4; i++) {
            realImageQuestions[
                    Provider.of<GamesControlProvider>(context, listen: false)
                        .getVoiceGameQuestionIndex]
                .option[i]
                .isVisible = false;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatRealAnimalScreen(),
            ),
          );
        } else if (widget.whichFunction == "knowWhatVirtualAnimalImage") {
          applicationData("Click Find Real Image");

          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionSkor();
          realImageQuestions.shuffle(Random());
          Provider.of<GamesControlProvider>(context, listen: false)
              .resetVoiceGameQuestionIndex();
          for (int i = 0; i < 4; i++) {
            virtualImageQuestions[
                    Provider.of<GamesControlProvider>(context, listen: false)
                        .getVoiceGameQuestionIndex]
                .option[i]
                .isVisible = false;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KnowWhatVirtualAnimalScreen(),
            ),
          );
        } else if (widget.whichFunction == "memoryGame") {
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
