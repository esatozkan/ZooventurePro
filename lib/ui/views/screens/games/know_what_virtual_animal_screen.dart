import '../../widgets/games_widgets/question_answer_game_widgets/question_answer_game_screen.dart';
import 'package:flutter/material.dart';
import '../../../../data/repository/generate_question.dart';

class KnowWhatVirtualAnimalScreen extends StatelessWidget {
  const KnowWhatVirtualAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionAnswerGameScreen(
      whichSkor: "knowWhatVirtualImage",
      whichPlayButton: "knowWhatVirtualImage",
      whichGameType: "see",
      whichList: virtualImageQuestions,
    );
  }
}
