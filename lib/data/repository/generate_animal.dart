import 'package:hive/hive.dart';
import '/data/models/animal_hive_model.dart';
import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';
import '../models/animal_model.dart';

void generateAnimal(context, String local) {
  AnimalProvider animalProvider = Provider.of(context);

  Box animalBox = Hive.box("Animals");

  if (animalBox.isEmpty) {
    for (int i = 0; i < animalProvider.getAnimalNames.length; i++) {
      Animal animal = Animal(
        name: animalProvider.getAnimalNames[i],
        voice: animalProvider.getAnimalVoices[i],
        gif: animalProvider.getAnimalGif[i],
        image: animalProvider.getAnimalVirtualImage[i],
        realImage: animalProvider.getAnimalVirtualImage[i],
        isVisible: false,
        isCorrectAnswer: false,
      );
      animalProvider.addAnimal(animal);

      final animalHive = AnimalHiveModel(
        animalProvider.getAnimalNames[i],
        animalProvider.getAnimalVoices[i],
        animalProvider.getAnimalGif[i],
        animalProvider.getAnimalVirtualImage[i],
        animalProvider.getAnimalRealImage[i],
        false,
        false,
      );
      animalBox.put(i, animalHive);
    }
  } else {
    for (int i = 0; i < animalBox.length; i++) {
      final animalHive = animalBox.get(i);

      animalProvider.addInformation(
        animalProvider.getAnimalGif,
        animalHive.gif,
      );

      animalProvider.addInformation(
        animalProvider.getAnimalRealImage,
        animalHive.realImage,
      );

      animalProvider.addInformation(
        animalProvider.getAnimalVirtualImage,
        animalHive.image,
      );

      animalProvider.addInformation(
        animalProvider.getAnimalVoices,
        animalHive.voice,
      );

      animalProvider.addInformation(
        animalProvider.getAnimalNames,
        animalHive.name,
      );

      Animal animal = Animal(
        name: animalHive.name,
        voice: animalHive.voice,
        gif: animalHive.gif,
        image: animalHive.image,
        realImage: animalHive.realImage,
        isVisible: animalHive.isVisible,
        isCorrectAnswer: animalHive.isCorrectAnswer,
      );
      animalProvider.addAnimal(animal);
    }
  }
}
