import 'package:hive/hive.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../services/animal_service.dart';
import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';
import '../models/animal_model.dart';

void generateAnimal(context, String local) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);

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
    animalRealImage.clear();
    animalVirtualImages.clear();
    animalNames.clear();
    animalVoices.clear();
  } else {
    for (int i = 0; i < animalBox.length; i++) {
      final getAnimalHive = animalBox.get(i);

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

  if (inAppPurchaseProvider.getBuy24Animal ||
      inAppPurchaseProvider.getIsPremiumSubscribed) {
    addAnimalToApp(24, context);
  }

  if (inAppPurchaseProvider.getBuy36Animal ||
      inAppPurchaseProvider.getIsPremiumSubscribed) {
    addAnimalToApp(36, context);
  }
}

generateBuyAnimal(int animalType) {
  Box animal24Box = Hive.box<Animal>("buy24animals");
  Box animal36Box = Hive.box<Animal>("buy36animals");

  for (int i = 0; i < animalNames.length; i++) {
    Animal animal = Animal(
      name: animalNames[i],
      voice: animalVoices[i],
      image: animalVirtualImages[i],
      realImage: animalRealImage[i],
      spelling: animalSpelling[i],
    );
    if (animalType == 24) {
      animal24Box.put(i, animal);
    } else {
      animal36Box.put(i, animal);
    }
  }
  animalNames.clear();
  animalRealImage.clear();
  animalSpelling.clear();
  animalVirtualImages.clear();
  animalVoices.clear();
}

addAnimalToApp(int animalType, context) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  if (animalType == 24) {
    Box animal24Box = Hive.box<Animal>("buy24animals");
    for (int i = 0; i < animal24Box.length; i++) {
      final getAnimal24Hive = animal24Box.get(i);
      Animal animal = Animal(
        name: getAnimal24Hive.name,
        voice: getAnimal24Hive.voice,
        image: getAnimal24Hive.image,
        realImage: getAnimal24Hive.realImage,
        spelling: getAnimal24Hive.spelling,
      );
      animalProvider.addAnimal(animal);
    }
  }

  if (animalType == 36) {
    Box animal36Box = Hive.box<Animal>("buy36animals");
    for (int i = 0; i < animal36Box.length; i++) {
      final getAnimal36Hive = animal36Box.get(i);
      Animal animal = Animal(
        name: getAnimal36Hive.name,
        voice: getAnimal36Hive.voice,
        image: getAnimal36Hive.image,
        realImage: getAnimal36Hive.realImage,
        spelling: getAnimal36Hive.spelling,
      );
      animalProvider.addAnimal(animal);
    }
  }
}

controlOfAddAnimalToApp(context) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  if (inAppPurchaseProvider.getIsPremiumSubscribed) {
    if (animalProvider.getAnimals.length == 24) {
      addAnimalToApp(24, context);
      addAnimalToApp(36, context);
    }
    if (animalProvider.getAnimals.length == 48) {
      addAnimalToApp(36, context);
    }
    if (animalProvider.getAnimals.length == 60) {
      addAnimalToApp(24, context);
    }
  } else {
    if (animalProvider.getAnimals.length == 24 &&
        inAppPurchaseProvider.getBuy24Animal) {
      addAnimalToApp(24, context);
    }
    if (animalProvider.getAnimals.length == 24 &&
        inAppPurchaseProvider.getBuy36Animal) {
      addAnimalToApp(36, context);
    }
  }
}
