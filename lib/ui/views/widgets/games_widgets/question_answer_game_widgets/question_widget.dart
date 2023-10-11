import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/repository/generate_question.dart';
import '../../../../providers/games_control_provider.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
    required this.whichVoice,
    required this.gameType,
  }) : super(key: key);
  final String whichVoice;
  final String gameType;

  @override
  State<QuestionWidget> createState() => _QuestionWidget();
}

class _QuestionWidget extends State<QuestionWidget> {
  final voicePlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    GamesControlProvider gamesControlProvider =
        Provider.of<GamesControlProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      child: widget.gameType == "see"
          ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Consumer<GamesControlProvider>(
                builder: (context, getVoiceGameQuestionIndex, _) =>
                    CachedNetworkImage(
                  imageUrl: widget.whichVoice == "knowWhatRealImage"
                      ? realImageQuestions[
                              gamesControlProvider.getVoiceGameQuestionIndex]
                          .animalVoice
                      : virtualImageQuestions[
                              gamesControlProvider.getVoiceGameQuestionIndex]
                          .animalVoice,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Consumer<GamesControlProvider>(
              builder: (context, gamesControlProvider, _) => notSee(),
            ),
    );
  }

  Widget notSee() {
    GamesControlProvider gamesControlProvider =
        Provider.of<GamesControlProvider>(context, listen: false);
    Timer(
      const Duration(milliseconds: 1400),
      () {
        if (widget.whichVoice == "KnowWhatHeardScreen") {
          voicePlayer.play(
            UrlSource(questions[gamesControlProvider.getVoiceGameQuestionIndex]
                .animalVoice),
          );
        } else if (widget.whichVoice == "knowWhatTypeAnimal") {
          voicePlayer.play(
            UrlSource(
                typeQuestions[gamesControlProvider.getVoiceGameQuestionIndex]
                    .animalVoice),
          );
        }
      },
    );
    return const Text("");
  }
}
