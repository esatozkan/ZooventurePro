import 'package:provider/provider.dart';
import 'word_model.dart';
import '../../../../providers/animal_provider.dart';

List<WordModel> sourceWords = [];

int populateSourceWords(context) {
  AnimalProvider animalProvider = Provider.of<AnimalProvider>(context,listen: false);

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    sourceWords.add(
      WordModel(
        text: animalProvider.getAnimals[i].spelling,
        url: animalProvider.getAnimals[i].image,
        displayText: false,
      ),
    );
  }
  return 1;
}
