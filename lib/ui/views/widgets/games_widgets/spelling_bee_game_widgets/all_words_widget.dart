import 'dart:math';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/word_model.dart';
import '../../../../providers/animal_provider.dart';

List<SpellingBeeGameWordModel> allWords = [];

spellingBeeGameGenerateAnimalWords(context) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    String animalLength = animalProvider.getAnimals[i].spelling!;
    if (animalLength.length < 7) {
      SpellingBeeGameWordModel spellingBeeGameWordModel =
          SpellingBeeGameWordModel(
        name: animalLength,
        url: animalProvider.getAnimals[i].image!,
      );
      allWords.add(spellingBeeGameWordModel);
    }
  }

  allWords.shuffle(Random());

  while (allWords.length > 6) {
    allWords.removeLast();
  }
}
