import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/data/repository/generate_question.dart';

class QuestionGameProvider extends ChangeNotifier {
  int numberOfQuestion = 3;
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

  Future<void> nextQuestion(int index, {String isVoice = ""}) async {
    answerControl = !answerControl;
    audioPlayer.play(
      AssetSource(
        question[questionIndex].option.values.toList()[index] == true
            ? "games/question_games/question_game_sounds/correct.mp3"
            : "games/question_games/question_game_sounds/incorrect.mp3",
      ),
    );

    if (questionIndex != numberOfQuestion) {
      await Future.delayed(const Duration(milliseconds: 1500), () {
        setIsVisibleListItem(index, false);
        answerControl = !answerControl;
        questionIndex++;
        onTap = true;
        if (isVoice == "knowWhatTypeAnimalScreen" &&
            questionIndex != numberOfQuestion) {
          audioPlayer.play(
            UrlSource(question[questionIndex].question.name),
          );
        }
        if (isVoice == "KnowWhatHearAnimalScreen" &&
            questionIndex != numberOfQuestion) {
          audioPlayer.play(
            UrlSource(question[questionIndex].question.voice),
          );
        }
      });
    }
    notifyListeners();
  }

  resetGame() {
    questionIndex = 0;
    answerControl = false;
    onTap = true;
  }
}
