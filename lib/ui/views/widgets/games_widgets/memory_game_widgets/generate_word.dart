import '/data/services/animal_service.dart';
import 'word_model.dart';

List<WordModel> sourceWords = [];

int populateSourceWords(context) {
  sourceWords.clear();

  for (int i = 0; i < freeAnimals.length; i++) {
    int startIndex =
        freeAnimals[i].animalVirtualImage.indexOf('animal_virtual_images/');
    int endIndex = freeAnimals[i].animalVirtualImage.indexOf(".png");
    String animalLength =
        freeAnimals[i].animalVirtualImage.substring(startIndex + 22, endIndex);
    sourceWords.add(
      WordModel(
        text: animalLength,
        url: freeAnimals[i].animalVirtualImage,
        displayText: false,
      ),
    );
  }
  return 1;
}
