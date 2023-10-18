import 'dart:math';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/word_model.dart';
import '../../../../providers/animal_provider.dart';

List<SpellingBeeGameWordModel> allWords = [];

spellingBeeGameGenerateAnimalWords(context) {
  AnimalProvider animalProvider = Provider.of(context);

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    int startIndex =
        animalProvider.getAnimals[i].image.indexOf('animal-virtual-images%2F');
    int endIndex = animalProvider.getAnimals[i].image.indexOf('.png');

    String animalLength =
        animalProvider.getAnimals[i].image.substring(startIndex + 24, endIndex);
    if (animalLength.length < 7) {
      SpellingBeeGameWordModel spellingBeeGameWordModel =
          SpellingBeeGameWordModel(
        name: animalLength,
        url: animalProvider.getAnimals[i].image,
      );
      allWords.add(spellingBeeGameWordModel);
    }
  }

  allWords.shuffle(Random());

  while (allWords.length > 6) {
    allWords.removeLast();
  }
}
