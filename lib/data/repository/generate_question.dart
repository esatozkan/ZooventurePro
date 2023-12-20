import 'dart:math';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';
import '/ui/providers/animal_provider.dart';
import '/data/services/question_service.dart';
import '../models/question_model.dart';

List<QuestionAnswerModel> question = [];

void generateQuestion(context) {
  AnimalProvider animalProvider = Provider.of(context, listen: false);
  QuestionGameProvider questionGameProvider =
      Provider.of(context, listen: false);

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    question.add(addQuestion(context, i));
  }

  question.shuffle(Random());
  question.removeRange(
      questionGameProvider.getNumberOfQuestion + 1, question.length);
}
