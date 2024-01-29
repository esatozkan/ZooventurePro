import 'dart:math';
import '/data/services/animal_service.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/word_model.dart';

List<SpellingBeeGameWordModel> allWords = [];

spellingBeeGameGenerateAnimalWords(context) {
  allWords.clear();

  for (int i = 0; i < freeAnimals.length; i++) {
    int startIndex =
        freeAnimals[i].animalVirtualImage.indexOf('animal_virtual_images/');
    int endIndex = freeAnimals[i].animalVirtualImage.indexOf(".png");
    String animalLength =
        freeAnimals[i].animalVirtualImage.substring(startIndex + 22, endIndex);
    if (animalLength.length < 7) {
      SpellingBeeGameWordModel spellingBeeGameWordModel =
          SpellingBeeGameWordModel(
        name: animalLength,
        url: freeAnimals[i].animalVirtualImage,
      );
      allWords.add(spellingBeeGameWordModel);
    }
  }

  allWords.shuffle(Random());

  allWords.removeRange(6, allWords.length);
}
