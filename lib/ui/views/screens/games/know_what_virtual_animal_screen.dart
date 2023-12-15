import 'package:flutter/material.dart';
import '../../widgets/games_widgets/question_games_widgets/question_game_widget.dart';

class KnowWhatVirtualAnimalScreen extends StatelessWidget {
  const KnowWhatVirtualAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionGameWidget(
      question: "knowWhatVirtualImage",
      background:
          "assets/games/question_games/find_virtual_image_background.png",
    );
  }
}
