import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_model.dart';
import '../../../../providers/animal_provider.dart';

List<WordModel> sourceWords = [];

int populateSourceWords(context) {
  AnimalProvider animalProvider = Provider.of(context);

  for (int i = 0; i < animalProvider.getAnimalVirtualImage.length; i++) {
    int startIndex = animalProvider.getAnimalVirtualImage[i]
        .indexOf('animal-virtual-images%2F');
    int endIndex = animalProvider.getAnimalVirtualImage[i].indexOf('.png');
    sourceWords.add(WordModel(
        text: animalProvider.getAnimalVirtualImage[i]
            .substring(startIndex + 24, endIndex),
        url: animalProvider.getAnimalVirtualImage[i],
        displayText: false));
  }
  return 1;
}
