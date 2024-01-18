import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flip_animation.dart';
import 'matched_animation_widget.dart';
import 'spin_animation.dart';
import 'word_model.dart';
import 'memory_games_provider.dart';

class WordTileWidget extends StatelessWidget {
  const WordTileWidget({
    Key? key,
    required this.index,
    required this.word,
  }) : super(key: key);

  final int index;
  final WordModel word;

  @override
  Widget build(BuildContext context) {
    return SpinAnimationWidget(
      child: Consumer<MemoryGamesProvider>(
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
                notifier.onAnimationCompleted(context, isForward: isForward);
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
                            ),
                          ),
                        )
                      : Image.memory(
                          word.url,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool checkAnimationRun(MemoryGamesProvider notifier) {
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
