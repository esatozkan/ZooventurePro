import 'dart:math';
import '/data/models/animal_model.dart';
import '/data/models/question_model.dart';
import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';

QuestionAnswerModel addQuestion(context, index) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  List<int> generatedRandomNumbers = [];
  Map<Animal, bool> generatedOptions = {};

  generatedRandomNumbers.add(index);
  generatedOptions[animalProvider.getAnimals[index]] = true;

  while (generatedRandomNumbers.length < 4) {
    int generatedRandomNumber;
    do {
      generatedRandomNumber = Random().nextInt(animalProvider.animals.length);
    } while (generatedRandomNumbers.contains(generatedRandomNumber));
    generatedRandomNumbers.add(generatedRandomNumber);
    generatedOptions[animalProvider.getAnimals[generatedRandomNumber]] = false;
  }

  List<MapEntry<Animal, bool>> entries = generatedOptions.entries.toList();
  entries.shuffle();
  generatedOptions.clear();
  generatedOptions = Map.fromEntries(entries);

  QuestionAnswerModel questionAnswerModel = QuestionAnswerModel(
    question: animalProvider.getAnimals[index],
    option: generatedOptions,
  );

  generatedRandomNumbers.clear();
  return questionAnswerModel;
}
