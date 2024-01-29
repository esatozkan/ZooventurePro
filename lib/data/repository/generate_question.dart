import 'dart:math';
import 'package:provider/provider.dart';
import '/data/services/animal_service.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';
import '/data/services/question_service.dart';
import '../models/question_model.dart';

List<QuestionModel> question = [];

void generateQuestion(context) {
  for (int i = 0; i < freeAnimals.length; i++) {
    question.add(addQuestion(i));
  }

  question.shuffle(Random());
  question.removeRange(
      Provider.of<QuestionGameProvider>(context, listen: false)
              .getNumberOfQuestion +
          1,
      question.length);
}

void clearQuestion() {
  question.clear();
}
