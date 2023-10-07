import '../../widgets/games_widgets/question_answer_game_widgets/question_answer_game_screen.dart';
import 'package:flutter/material.dart';
import '../../../../data/repository/generate_question.dart';

class KnowWhatRealAnimalScreen extends StatelessWidget {
  const KnowWhatRealAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionAnswerGameScreen(
      whichSkor: "knowWhatRealImage",
      whichPlayButton: "knowWhatRealImage",
      whichGameType: "see",
      whichList: realImageQuestions,
    );
  }
}
