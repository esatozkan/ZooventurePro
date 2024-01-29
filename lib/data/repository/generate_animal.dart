import 'dart:io';
import '/data/models/animal_model.dart';
import '/data/services/animal_service.dart';

void generateFreeAnimal() {
  for (int i = 0; i < freeAnimalVirtualImages.length; i++) {
    AnimalModel animalModel = AnimalModel(
      animalVirtualImage: freeAnimalVirtualImages[i],
      animalRealImage: freeAnimalRealImages[i],
      animalVoice: freeAnimalVoices[i],
      animalType: Platform.localeName.split("_")[0] == "tr"
          ? freeAnimalTr[i]
          : Platform.localeName.split("_")[0] == "id"
              ? freeAnimalId[i]
              : Platform.localeName.split("_")[0] == "hi"
                  ? freeAnimalHi[i]
                  : Platform.localeName.split("_")[0] == "it"
                      ? freeAnimalIt[i]
                      : Platform.localeName.split("_")[0] == "de"
                          ? freeAnimalDe[i]
                          : freeAnimalEn[i],
    );
    freeAnimals.add(animalModel);
  }
}

void generateBuy24Animal() {
  for (int i = 0; i < buy24AnimalVirtualImages.length; i++) {
    AnimalModel animalModel = AnimalModel(
      animalVirtualImage: buy24AnimalVirtualImages[i],
      animalRealImage: buy24AnimalRealImages[i],
      animalVoice: buy24AnimalVoices[i],
      animalType: Platform.localeName.split("_")[0] == "tr"
          ? buy24AnimalTr[i]
          : Platform.localeName.split("_")[0] == "id"
              ? buy24AnimalId[i]
              : Platform.localeName.split("_")[0] == "hi"
                  ? buy24AnimalHi[i]
                  : Platform.localeName.split("_")[0] == "it"
                      ? buy24AnimalIt[i]
                      : Platform.localeName.split("_")[0] == "de"
                          ? buy24AnimalDe[i]
                          : buy24AnimalEn[i],
    );
    buy24Animals.add(animalModel);
  }
}

void generateBuy36Animal() {
  for (int i = 0; i < buy36AnimalVirtualImages.length; i++) {
    AnimalModel animalModel = AnimalModel(
      animalVirtualImage: buy36AnimalVirtualImages[i],
      animalRealImage: buy36AnimalRealImages[i],
      animalVoice: buy36AnimalVoice[i],
      animalType: Platform.localeName.split("_")[0] == "tr"
          ? buy36AnimalTr[i]
          : Platform.localeName.split("_")[0] == "id"
              ? buy36AnimalId[i]
              : Platform.localeName.split("_")[0] == "hi"
                  ? buy36AnimalHi[i]
                  : Platform.localeName.split("_")[0] == "it"
                      ? buy36AnimalIt[i]
                      : Platform.localeName.split("_")[0] == "de"
                          ? buy36AnimalDe[i]
                          : buy36AnimalEn[i],
    );
    buy36Animals.add(animalModel);
  }
}
