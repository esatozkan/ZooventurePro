import '../../widgets/games_widgets/question_answer_game_widgets/question_answer_game_screen.dart';
import 'package:flutter/material.dart';
import '../../../../data/repository/generate_question.dart';

class KnowWhatHearScreen extends StatelessWidget {
  const KnowWhatHearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionAnswerGameScreen(
      whichSkor: "KnowWhatHeardScreen",
      whichPlayButton: "KnowWhatHeardScreen",
      whichGameType: "",
      whichList: questions,
    );
  }
}
