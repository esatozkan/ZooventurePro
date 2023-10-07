import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';
import '../models/animal_model.dart';

void generateAnimal(context) {
  AnimalProvider animalProvider = Provider.of(context);
  for (int i = 0; i < animalProvider.getAnimalNames.length; i++) {
    Animal animal = Animal();
    animal.name = animalProvider.getAnimalNames[i];
    animal.voice = animalProvider.getAnimalVoices[i];
    animal.image = animalProvider.getAnimalVirtualImage[i];
    animal.realImage = animalProvider.getAnimalRealImage[i];
    animal.isVisible = false;
    animal.isCorrectAnswer = false;
    Provider.of<AnimalProvider>(context, listen: false).addAnimal(animal);
  }
}
