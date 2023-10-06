import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/repository/generate_question.dart';
import '../../../../providers/games_control_provider.dart';


class SkorWidget extends StatelessWidget {
  const SkorWidget({
    Key? key,
    required this.whichGameReset,
  }) : super(key: key);

  final String whichGameReset;

  void resetGame(context, whichButton) {
    if (whichButton == "newGame") {
      if (whichGameReset == "KnowWhatHeardScreen") {
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
      } else if (whichGameReset == "knowWhatTypeAnimal") {
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
      } else if (whichGameReset == "knowWhatRealImage") {
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
      } else if (whichGameReset == "knowWhatVirtualImage") {
        Provider.of<GamesControlProvider>(context, listen: false)
            .resetVoiceGameQuestionSkor();
        virtualImageQuestions.shuffle(Random());
        Provider.of<GamesControlProvider>(context, listen: false)
            .resetVoiceGameQuestionIndex();
        for (int i = 0; i < 4; i++) {
          virtualImageQuestions[
                  Provider.of<GamesControlProvider>(context, listen: false)
                      .getVoiceGameQuestionIndex]
              .option[i]
              .isVisible = false;
        }
      }
    } else if (whichButton == "backButton") {
      if (whichGameReset == "KnowWhatHeardScreen") {
        questions.shuffle(Random());
        for (int i = 0; i < 4; i++) {
          questions[Provider.of<GamesControlProvider>(context, listen: false)
                  .getVoiceGameQuestionIndex]
              .option[i]
              .isVisible = false;
        }
      } else if (whichGameReset == "knowWhatTypeAnimal") {
        typeQuestions.shuffle(Random());
        for (int i = 0; i < 4; i++) {
          typeQuestions[
                  Provider.of<GamesControlProvider>(context, listen: false)
                      .getVoiceGameQuestionIndex]
              .option[i]
              .isVisible = false;
        }
      } else if (whichGameReset == "knowWhatRealImage") {
        realImageQuestions.shuffle(Random());
        for (int i = 0; i < 4; i++) {
          realImageQuestions[
                  Provider.of<GamesControlProvider>(context, listen: false)
                      .getVoiceGameQuestionIndex]
              .option[i]
              .isVisible = false;
        }
      } else if (whichGameReset == "knowWhatVirtualImage") {
        virtualImageQuestions.shuffle(Random());
        for (int i = 0; i < 4; i++) {
          virtualImageQuestions[
                  Provider.of<GamesControlProvider>(context, listen: false)
                      .getVoiceGameQuestionIndex]
              .option[i]
              .isVisible = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50),
              child: IconButton(
                onPressed: () {
                  resetGame(
                    context,
                    "backButton",
                  );
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/game_control/back_icon.png",
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: () {
                  resetGame(
                    context,
                    "newGame",
                  );
                },
                icon: Image.asset(
                  "assets/bottom_navbar_icon/gameScreenIcon.png",
                  height: 60,
                  width: 60,
                  color: Colors.green,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
