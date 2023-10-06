import '../../data/repository/game_control_repository.dart';
import 'package:flutter/material.dart';

class GamesControlProvider with ChangeNotifier {
  int voiceGameQuestionIndex = 0;
  int voiceGameSkor = 0;
  int foodGameQuestionIndex = 0;
  int foodGamesSkor = 0;
  bool gameOver = false;

  int get getVoiceGameQuestionIndex => voiceGameQuestionIndex;
  int get getVoiceGameSkor => voiceGameSkor;
  int get getFoodGameQuestionIndex => foodGameQuestionIndex;
  int get getFoodGamesSkor => foodGamesSkor;
  bool get getGameOver => gameOver;

  var gamesControlRepo = GameControlRepository();

  void incrementVoiceGameQuestionIndex() {
    voiceGameQuestionIndex =
        gamesControlRepo.incrementIndex(voiceGameQuestionIndex);
    notifyListeners();
  }

  void resetVoiceGameQuestionIndex() {
    voiceGameQuestionIndex =
        gamesControlRepo.resetIndex(voiceGameQuestionIndex);
    notifyListeners();
  }

  void incrementVoiceGameQuestionSkor() {
    voiceGameSkor = gamesControlRepo.incrementIndex(voiceGameSkor);
    notifyListeners();
  }

  void resetVoiceGameQuestionSkor() {
    voiceGameSkor = gamesControlRepo.resetIndex(voiceGameSkor);
    notifyListeners();
  }

  void isGameOver() {
    gameOver = gamesControlRepo.isGameOver(gameOver);
    notifyListeners();
  }
  
}
