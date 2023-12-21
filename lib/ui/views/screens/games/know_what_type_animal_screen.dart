import 'package:flutter/material.dart';
import '../../widgets/games_widgets/question_games_widgets/question_game_widget.dart';

class KnowWhatTypeAnimalScreen extends StatelessWidget {
  const KnowWhatTypeAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return QuestionGameWidget(
      question: "knowWhatTypeAnimalScreen",
      background: "assets/games/question_games/find_animal_type_background.png",
    );
  }
}
