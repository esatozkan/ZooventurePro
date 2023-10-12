// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/spin_animation.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/matched_animation_widget.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_provider.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/flip_animation.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_model.dart';

class WordTile extends StatelessWidget {
  const WordTile({
    Key? key,
    required this.index,
    required this.word,
  }) : super(key: key);

  final int index;
  final WordModel word;

  @override
  Widget build(BuildContext context) {
    return SpinAnimationWidget(
      child: Consumer<WordPictureMemoryGameProvider>(
        builder: (_, notifier, __) {
          bool animate = checkAnimationRun(notifier);

          return GestureDetector(
            onTap: () {
              if (!notifier.ignoreTaps &&
                  !notifier.answerWords.contains(index) &&
                  !notifier.tappedWords.containsKey(index)) {
                notifier.tileTapped(index: index, word: word);
              }
            },
            child: FlipAnimationWidget(
              delay: notifier.reserveFlip ? 1500 : 0,
              reverse: notifier.reserveFlip,
              animatedCompleted: (isForward) {
                notifier.onAnimationCompleted(isForward: isForward);
              },
              animate: animate,
              word: MatchedAnimationWidget(
                numberOfWordAnswered: notifier.answerWords.length,
                animate: notifier.answerWords.contains(index),
                child: Container(
                    child: word.displayText
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FittedBox(
                                child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Text(
                                word.text,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "bubblegumSans"),
                              ),
                            )),
                          )
                        : CachedNetworkImage(
                            imageUrl: word.url,
                            fit: BoxFit.cover,
                          )),
              ),
            ),
          );
        },
      ),
    );
  }

  bool checkAnimationRun(WordPictureMemoryGameProvider notifier) {
    bool animate = false;

    if (notifier.canFlip) {
      if (notifier.tappedWords.isNotEmpty &&
          notifier.tappedWords.keys.last == index) {
        animate = true;
      }
      if (notifier.reserveFlip && !notifier.answerWords.contains(index)) {
        animate = true;
      }
    }
    return animate;
  }
}
