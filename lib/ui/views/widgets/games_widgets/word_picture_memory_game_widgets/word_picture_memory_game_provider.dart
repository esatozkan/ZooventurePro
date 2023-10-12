import 'package:flutter/material.dart';
import '/data/repository/game_control_repository.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/game_audio_widget.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_model.dart';

class WordPictureMemoryGameProvider extends ChangeNotifier {
  Map<int, WordModel> tappedWords = {};
  bool canFlip = false;
  bool reserveFlip = false;
  bool ignoreTaps = false;
  bool roundCompleted = false;
  List<int> answerWords = [];
  int move = 0;
  int difficulty = 0;

  int get getMove => move;
  int get getDifficulty => difficulty;

  GameControlRepository gameControlRepository = GameControlRepository();

  void setValue(int value) {
    difficulty = gameControlRepository.setIndex(value);
    notifyListeners();
  }

  tileTapped({required int index, required WordModel word}) {
    ignoreTaps = true;
    if (tappedWords.length <= 1) {
      tappedWords.addEntries([MapEntry(index, word)]);
      canFlip = true;
    } else {
      canFlip = false;
    }
    notifyListeners();
  }

  onAnimationCompleted({required bool isForward}) async {
    if (tappedWords.length == 2) {
      if (isForward) {
        if (tappedWords.entries.elementAt(0).value.text ==
            tappedWords.entries.elementAt(1).value.text) {
          answerWords.addAll(tappedWords.keys);
          if (answerWords.length == 8) {
            print("*******************");
            print(difficulty);
            move = 0;
            await GameAudioWidget.playAudio("Round");

            roundCompleted = true;
          } else {
            move++;
            await GameAudioWidget.playAudio("Correct");
          }
          tappedWords.clear();
          canFlip = true;
          ignoreTaps = false;
        } else {
          move++;
          await GameAudioWidget.playAudio("Incorrect");
          reserveFlip = true;
        }
      } else {
        reserveFlip = false;
        tappedWords.clear();
        ignoreTaps = false;
      }
    } else {
      canFlip = false;
      ignoreTaps = false;
    }
    notifyListeners();
  }
}
