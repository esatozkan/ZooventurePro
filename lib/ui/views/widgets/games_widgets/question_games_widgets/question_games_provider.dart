import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../screens/main_screen.dart';
import '/data/repository/generate_question.dart';

class QuestionGameProvider extends ChangeNotifier {
  int numberOfQuestion = 10;
  int questionIndex = 0;
  bool answerControl = false;
  bool onTap = true;
  List<bool> isVisibleList = List.filled(4, false);

  bool get getAnswerControl => answerControl;
  bool get getOnTap => onTap;
  int get getQuestionIndex => questionIndex;
  int get getNumberOfQuestion => numberOfQuestion;
  List<bool> get getIsVisibleList => isVisibleList;

  AudioPlayer audioPlayer = AudioPlayer();

  setIsVisibleListItem(int index, bool val) {
    isVisibleList[index] = val;
    notifyListeners();
  }

  setAnswerControl() {
    answerControl = !answerControl;
    notifyListeners();
  }

  Future<void> nextQuestion(int index, context, {String isVoice = ""}) async {
    answerControl = !answerControl;

    if (question[questionIndex].option.values.toList()[index] == false) {
      await audioPlayer.play(
        AssetSource(
          "games/question_games/question_game_sounds/incorrect.mp3",
        ),
      );
      answerControl = !answerControl;
    } else {
      await audioPlayer.play(
        AssetSource(
          "games/question_games/question_game_sounds/correct.mp3",
        ),
      );
      if (questionIndex != numberOfQuestion) {
        await Future.delayed(const Duration(milliseconds: 1500), () {
          setIsVisibleListItem(index, false);
          answerControl = !answerControl;
          isVisibleList = List.filled(4, false);
          questionIndex++;
          onTap = true;
          if (isVoice == "knowWhatTypeAnimalScreen" &&
              questionIndex != numberOfQuestion) {
            audioPlayer
                .play(AssetSource(question[questionIndex].question.animalType));
          } else if (isVoice == "KnowWhatHearAnimalScreen" &&
              questionIndex != numberOfQuestion) {
            audioPlayer.play(
                AssetSource(question[questionIndex].question.animalVoice));
          } else {
            googleAdsProvider.showInterstitialAd(context);
          }
        });
      }
    }

    notifyListeners();
  }

  resetGame(context) {
    questionIndex = 0;
    answerControl = false;
    onTap = true;
  }
}
