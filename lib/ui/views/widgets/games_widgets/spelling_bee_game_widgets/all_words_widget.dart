import 'dart:math';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/word_model.dart';
import '../../../../providers/animal_provider.dart';

List<SpellingBeeGameWordModel> allWords = [];

spellingBeeGameGenerateAnimalWords(context) {
  AnimalProvider animalProvider = Provider.of(context);

  for (int i = 0; i < animalProvider.getAnimalVirtualImage.length; i++) {
    int startIndex = animalProvider.getAnimalVirtualImage[i]
        .indexOf('animal-virtual-images%2F');
    int endIndex = animalProvider.getAnimalVirtualImage[i].indexOf('.png');

    String animalLength = animalProvider.getAnimalVirtualImage[i]
        .substring(startIndex + 24, endIndex);
    if (animalLength.length < 7) {
      SpellingBeeGameWordModel spellingBeeGameWordModel =
          SpellingBeeGameWordModel(
        name: animalLength,
        url: animalProvider.getAnimalVirtualImage[i],
      );
      allWords.add(spellingBeeGameWordModel);
    }
  }

  allWords.shuffle(Random());

  while (allWords.length > 6) {
    allWords.removeLast();
  }
}
