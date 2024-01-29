import 'dart:math';
import '/data/services/animal_service.dart';
import '/data/models/animal_model.dart';
import '/data/models/question_model.dart';

QuestionModel addQuestion(index) {
  List<int> generatedRandomNumbers = [];
  Map<AnimalModel, bool> generatedOptions = {};

  generatedRandomNumbers.add(index);
  generatedOptions[freeAnimals[index]] = true;

  while (generatedRandomNumbers.length < 4) {
    int generatedRandomNumber;
    do {
      generatedRandomNumber = Random().nextInt(freeAnimals.length);
    } while (generatedRandomNumbers.contains(generatedRandomNumber));
    generatedRandomNumbers.add(generatedRandomNumber);
    generatedOptions[freeAnimals[generatedRandomNumber]] = false;
  }

  List<MapEntry<AnimalModel, bool>> entries = generatedOptions.entries.toList();
  entries.shuffle();
  generatedOptions.clear();
  generatedOptions = Map.fromEntries(entries);

  QuestionModel questionModel = QuestionModel(
    question: freeAnimals[index],
    option: generatedOptions,
  );
  generatedRandomNumbers.clear();
  return questionModel;
}
