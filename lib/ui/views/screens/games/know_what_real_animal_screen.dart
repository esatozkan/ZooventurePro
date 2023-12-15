import 'package:flutter/material.dart';
import '../../widgets/games_widgets/question_games_widgets/question_game_widget.dart';

class KnowWhatRealAnimalScreen extends StatelessWidget {
  const KnowWhatRealAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionGameWidget(
      question: "knowWhatRealImage",
      background: "assets/games/question_games/find_real_image_background.png",
    );
  }
}
