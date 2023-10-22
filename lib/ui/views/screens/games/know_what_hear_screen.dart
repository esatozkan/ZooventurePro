import 'package:flutter/material.dart';
import '../../widgets/games_widgets/question_games_widgets/question_game_widget.dart';

class KnowWhatHearAnimalScreen extends StatelessWidget {
  const KnowWhatHearAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionGameWidget(
      question: "KnowWhatHearAnimalScreen",
      background:
          "assets/games/question_games/find_animal_sounds_background.png",
    );
  }
}
