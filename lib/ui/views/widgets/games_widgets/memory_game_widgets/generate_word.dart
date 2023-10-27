import 'package:provider/provider.dart';
import 'word_model.dart';
import '../../../../providers/animal_provider.dart';

List<WordModel> sourceWords = [];

int populateSourceWords(context) {
  AnimalProvider animalProvider = Provider.of(context);

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    int startIndex =
        animalProvider.getAnimals[i].image.indexOf('animal-virtual-images%2F');
    int endIndex = animalProvider.getAnimals[i].image.indexOf('.');
    sourceWords.add(WordModel(
        text: animalProvider.getAnimals[i].image
            .substring(startIndex + 24, endIndex),
        url: animalProvider.getAnimals[i].image,
        displayText: false));
  }
  return 1;
}
