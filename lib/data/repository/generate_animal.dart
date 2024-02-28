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
