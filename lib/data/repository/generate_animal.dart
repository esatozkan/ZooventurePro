import 'package:hive/hive.dart';
import '../services/animal_service.dart';
import '/data/models/animal_hive_model.dart';
import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';
import '../models/animal_model.dart';

void generateAnimal(context, String local) {
  AnimalProvider animalProvider = Provider.of(context);

  Box animalBox = Hive.box("Animals");

  if (animalBox.isEmpty) {
    for (int i = 0; i < animalNames.length; i++) {
      Animal animal = Animal(
        name: animalNames[i],
        voice: animalVoices[i],
        gif: animalGif[i],
        image: animalVirtualImages[i],
        realImage: animalRealImage[i],
      );
      animalProvider.addAnimal(animal);

      final animalHive = AnimalHiveModel(
        animalNames[i],
        animalVoices[i],
        animalGif[i],
        animalVirtualImages[i],
        animalRealImage[i],
      );
      animalBox.put(i, animalHive);
    }
  } else {
    for (int i = 0; i < animalBox.length; i++) {
      final animalHive = animalBox.get(i);

      animalGif.add(animalHive.gif);
      animalRealImage.add(animalHive.realImage);
      animalVirtualImages.add(animalHive.image);
      animalVoices.add(animalHive.voice);
      animalNames.add(animalHive.name);

      Animal animal = Animal(
        name: animalHive.name,
        voice: animalHive.voice,
        gif: animalHive.gif,
        image: animalHive.image,
        realImage: animalHive.realImage,
      );
      animalProvider.addAnimal(animal);
    }
  }
}
