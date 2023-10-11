import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/models/question_model.dart';
import '/ui/views/widgets/games_widgets/question_answer_game_widgets/game_over_widget.dart';
import '/ui/views/widgets/games_widgets/question_answer_game_widgets/question_widget.dart';
import '/ui/views/widgets/games_widgets/question_answer_game_widgets/skor_widget.dart';
import '../../../../../data/repository/generate_question.dart';
import '/ui/providers/games_control_provider.dart';

// ignore: must_be_immutable
class QuestionAnswerGameScreen extends StatefulWidget {
  final String whichSkor;
  final String whichPlayButton;
  final String whichGameType;
  final List<QuestionModel> whichList;
  const QuestionAnswerGameScreen({
    Key? key,
    required this.whichSkor,
    required this.whichPlayButton,
    required this.whichGameType,
    required this.whichList,
  }) : super(key: key);

  @override
  State<QuestionAnswerGameScreen> createState() => _QuestionAnswerGameScreen();
}

class _QuestionAnswerGameScreen extends State<QuestionAnswerGameScreen> {
  final voicePlayer = AudioPlayer();

  Widget seeRightKnow() {
    voicePlayer.play(
      AssetSource("child_yeeh.mp3"),
    );
    return Image.asset(
      "assets/check_answer/correct_answer.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SkorWidget(
                    whichGameReset: widget.whichSkor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      QuestionWidget(
                        whichVoice: widget.whichPlayButton,
                        gameType: widget.whichGameType,
                      ),
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, index) {
                            return Consumer<GamesControlProvider>(
                              builder: (context, gamesControlProvider, _) =>
                                  Stack(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      answerControl(index);
                                    },
                                    icon: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.whichSkor ==
                                                "knowWhatVirtualImage"
                                            ? virtualImageQuestions[
                                                    gamesControlProvider
                                                        .getVoiceGameQuestionIndex]
                                                .option[index]
                                                .realImage
                                            : widget
                                                .whichList[gamesControlProvider
                                                    .getVoiceGameQuestionIndex]
                                                .option[index]
                                                .image,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget
                                        .whichList[gamesControlProvider
                                            .getVoiceGameQuestionIndex]
                                        .option[index]
                                        .isVisible,
                                    child: widget.whichGameType == "see"
                                        ? widget
                                                    .whichList[gamesControlProvider
                                                        .getVoiceGameQuestionIndex]
                                                    .option[index]
                                                    .isCorrectAnswer ==
                                                true
                                            ? seeRightKnow()
                                            : Image.asset(
                                                "assets/check_answer/wrong_answer.png",
                                              )
                                        : widget
                                                    .whichList[gamesControlProvider
                                                        .getVoiceGameQuestionIndex]
                                                    .option[index]
                                                    .isCorrectAnswer ==
                                                true
                                            ? Image.asset(
                                                "assets/check_answer/correct_answer.png",
                                              )
                                            : Image.asset(
                                                "assets/check_answer/wrong_answer.png",
                                              ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const GameOverWidget(),
          ],
        ),
      ),
    );
  }

  void answerControl(index) {
    GamesControlProvider gamesControlProvider =
        Provider.of<GamesControlProvider>(context, listen: false);
    if (Provider.of<GamesControlProvider>(context, listen: false)
            .getVoiceGameSkor !=
        widget.whichList.length) {
      widget.whichList[gamesControlProvider.getVoiceGameQuestionIndex]
          .option[index].isVisible = true;

      if (widget.whichSkor == "KnowWhatHeardScreen") {
        if (questions[gamesControlProvider.getVoiceGameQuestionIndex]
                .animalVoice ==
            questions[gamesControlProvider.getVoiceGameQuestionIndex]
                .option[index]
                .voice) {
          setState(
            () {
              questions[gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = true;
              gamesControlProvider.incrementVoiceGameQuestionSkor();
              wait(context, widget);
            },
          );
        } else {
          setState(
            () {
              questions[gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = false;
            },
          );
        }
      } else if (widget.whichSkor == "knowWhatRealImage") {
        if (realImageQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                .animalVoice ==
            realImageQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                .option[index]
                .realImage) {
          setState(
            () {
              realImageQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = true;
              gamesControlProvider.incrementVoiceGameQuestionSkor();
              wait(context, widget);
            },
          );
        } else {
          setState(
            () {
              realImageQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = false;
            },
          );
        }
      } else if (widget.whichSkor == "knowWhatTypeAnimal") {
        if (typeQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                .animalVoice ==
            typeQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                .option[index]
                .name) {
          setState(
            () {
              typeQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = true;
              gamesControlProvider.incrementVoiceGameQuestionSkor();
              wait(context, widget);
            },
          );
        } else {
          setState(
            () {
              typeQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = false;
            },
          );
        }
      } else if (widget.whichSkor == "knowWhatVirtualImage") {
        if (virtualImageQuestions[
                    gamesControlProvider.getVoiceGameQuestionIndex]
                .animalVoice ==
            virtualImageQuestions[
                    gamesControlProvider.getVoiceGameQuestionIndex]
                .option[index]
                .image) {
          setState(
            () {
              virtualImageQuestions[
                      gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = true;
              gamesControlProvider.incrementVoiceGameQuestionSkor();
              wait(context, widget);
            },
          );
        } else {
          setState(
            () {
              virtualImageQuestions[
                      gamesControlProvider.getVoiceGameQuestionIndex]
                  .option[index]
                  .isCorrectAnswer = false;
            },
          );
        }
      }
    }
  }
}

void wait(context, widget) {
  Timer(
    const Duration(milliseconds: 1300),
    () {
      GamesControlProvider gameControlProvider =
          Provider.of<GamesControlProvider>(context, listen: false);
      if (gameControlProvider.getVoiceGameSkor == widget.whichList.length) {
        gameControlProvider.isGameOver();
        for (int i = 0; i < 4; i++) {
          widget.whichList[gameControlProvider.getVoiceGameQuestionIndex]
              .option[i].isVisible = false;
        }
      } else {
        gameControlProvider.incrementVoiceGameQuestionIndex();
        for (int i = 0; i < 4; i++) {
          widget.whichList[gameControlProvider.getVoiceGameQuestionIndex]
              .option[i].isVisible = false;
        }
      }
    },
  );
}
