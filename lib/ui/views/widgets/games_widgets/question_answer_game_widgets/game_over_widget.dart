import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/repository/generate_question.dart';
import '../../../../providers/games_control_provider.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesControlProvider>(
      builder: (context, gamesControlProvider, _) => Padding(
        padding: const EdgeInsets.only(left: 200),
        child: SingleChildScrollView(
          child: Visibility(
            visible: gamesControlProvider.gameOver,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/game_control/game_over.gif",
                  
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                ),
                IconButton(
                  onPressed: () {
                    gamesControlProvider.resetVoiceGameQuestionSkor();
                    questions.shuffle(Random());
                    typeQuestions.shuffle(Random());
                    realImageQuestions.shuffle(Random());
                    gamesControlProvider.resetVoiceGameQuestionIndex();
                    gamesControlProvider.isGameOver();
                    for (int i = 0; i < 4; i++) {
                      questions[Provider.of<GamesControlProvider>(context,
                                  listen: false)
                              .getVoiceGameQuestionIndex]
                          .option[i]
                          .isVisible = false;
                      typeQuestions[Provider.of<GamesControlProvider>(context,
                                  listen: false)
                              .getVoiceGameQuestionIndex]
                          .option[i]
                          .isVisible = false;
                      realImageQuestions[Provider.of<GamesControlProvider>(context,
                                  listen: false)
                              .getVoiceGameQuestionIndex]
                          .option[i]
                          .isVisible = false;
                      virtualImageQuestions[Provider.of<GamesControlProvider>(
                                  context,
                                  listen: false)
                              .getVoiceGameQuestionIndex]
                          .option[i]
                          .isVisible = false;
                    }
                  },
                  icon: Image.asset(
                    "assets/game_control/start.png",
                    height: 50,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
