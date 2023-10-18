import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/all_words_widget.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/message_widget.dart';

class SpellingBeeGameProvider extends ChangeNotifier {
  int totalLetters = 0;
  int letterAnswered = 0;
  int wordsAnswered = 0;
  bool generateWord = true;
  bool sessionCompleted = false;
  bool letterDropped = false;
  double percentCompleted = 0;

  setup({required int total}) {
    letterAnswered = 0;
    totalLetters = total;
    notifyListeners();
  }

  incrementLetters({required BuildContext context}) {
    final player = AudioPlayer();

    letterAnswered++;

    updateLetterDropped(dropped: true);
    if (letterAnswered == totalLetters) {
      player.play(AssetSource("games/spelling_bee_games/spelling_bee_game_sounds/correct_2.mp3"));
      wordsAnswered++;
      percentCompleted = wordsAnswered / allWords.length;
      if (wordsAnswered == allWords.length) {
        sessionCompleted = true;
      }
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => MessageWidget(
          sessionCompleted: sessionCompleted,
        ),
      );
    } else {
      player.play(AssetSource("games/spelling_bee_games/spelling_bee_game_sounds/correct_1.mp3"));
    }
    notifyListeners();
  }

  requestWord({required bool request}) {
    generateWord = request;
    notifyListeners();
  }

  updateLetterDropped({required bool dropped}) {
    letterDropped = dropped;
    notifyListeners();
  }

  resetGame() {
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
  }
}
