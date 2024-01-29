import '/data/services/animal_service.dart';
import '../services/text_services.dart';

void changeLanguage(int index) {
  texts.clear();
  int j = 0;
  if (index == 0) {
    texts.addAll(textDe);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalDe[i];
    }
    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalDe[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalDe[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalDe[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalDe[j];
        j++;
      }
      j = 0;
    }
  } else if (index == 1) {
    texts.addAll(textEn);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalEn[i];
    }
    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalEn[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalEn[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalEn[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalEn[j];
        j++;
      }
      j = 0;
    }
  } else if (index == 2) {
    texts.addAll(textHi);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalHi[i];
    }
    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalHi[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalHi[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalHi[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalHi[j];
        j++;
      }
      j = 0;
    }
  } else if (index == 3) {
    texts.addAll(textId);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalId[i];
    }
    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalId[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalId[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalId[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalId[j];
        j++;
      }
      j = 0;
    }
  } else if (index == 4) {
    texts.addAll(textIt);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalIt[i];
    }

    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalIt[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalIt[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalIt[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalIt[j];
        j++;
      }
      j = 0;
    }
  } else if (index == 5) {
    texts.addAll(textTr);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalTr[i];
    }
    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalTr[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalTr[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalTr[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalTr[j];
        j++;
      }
      j = 0;
    }
  } else {
    texts.addAll(textEn);
    for (int i = 0; i < 24; i++) {
      freeAnimals[i].animalType = freeAnimalEn[i];
    }
    if (freeAnimals.length == 48) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy24AnimalEn[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 60) {
      for (int i = 24; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalEn[j];
        j++;
      }
      j = 0;
    }

    if (freeAnimals.length == 84) {
      for (int i = 24; i < 48; i++) {
        freeAnimals[i].animalType = buy24AnimalEn[j];
        j++;
      }
      j = 0;
      for (int i = 48; i < freeAnimals.length; i++) {
        freeAnimals[i].animalType = buy36AnimalEn[j];
        j++;
      }
      j = 0;
    }
  }
}
