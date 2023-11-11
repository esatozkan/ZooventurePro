import 'package:hive/hive.dart';
import '../services/animal_service.dart';
import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';
import '../models/animal_model.dart';

void generateAnimal(context, String local) {
  AnimalProvider animalProvider = Provider.of(context);

  Box animalBox = Hive.box<Animal>("animals");

  if (animalBox.isEmpty) {
    for (int i = 0; i < animalNames.length; i++) {
      Animal animal = Animal(
        name: animalNames[i],
        voice: animalVoices[i],
        image: animalVirtualImages[i],
        realImage: animalRealImage[i],
        spelling: animalSpelling[i],
      );
      animalProvider.addAnimal(animal);

      animalBox.put(i, animal);
    }
  } else {
    for (int i = 0; i < animalBox.length; i++) {
      final getAnimalHive = animalBox.get(i);

      animalRealImage.add(getAnimalHive.realImage);
      animalVirtualImages.add(getAnimalHive.image);
      animalVoices.add(getAnimalHive.voice);
      animalNames.add(getAnimalHive.name);
      animalSpelling.add(getAnimalHive.spelling);

      Animal animal = Animal(
        name: getAnimalHive.name,
        voice: getAnimalHive.voice,
        image: getAnimalHive.image,
        realImage: getAnimalHive.realImage,
        spelling: getAnimalHive.spelling,
      );
      animalProvider.addAnimal(animal);
    }
  }
}
