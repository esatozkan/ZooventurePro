import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/language_provider.dart';
import '/ui/providers/animal_provider.dart';
import '/data/services/text_services.dart';

void getLanguageFlag(String local, BuildContext context) {
  LanguageProvider languageProvider = Provider.of(context, listen: false);

  for (int i = 0; i < languageProvider.getLanguageService.length; i++) {
    if (languageProvider.getLanguageService[i].contains("$local.png")) {
      languageProvider.setFlagIndex(i);
      break;
    }
  }

  if (languageProvider.getFlagIndex == -1) {
    for (int i = 0; i < languageProvider.getLanguageService.length; i++) {
      if (languageProvider.getLanguageService[i].contains("en.png")) {
        languageProvider.setFlagIndex(i);
        break;
      }
    }
  }
}

Future chanceLocal(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  List<String> getUrls = [];

  animalProvider.clearList(animalProvider.getUiTexts);
  languageProvider.chanceLocal();

  final storageRef = FirebaseStorage.instance
      .ref()
      .child("free-animals/animal-types/animal-type-${languageProvider.getLocal}");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    getUrls.add(await element.getDownloadURL());
  }

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    animalProvider.getAnimals[i].name = getUrls[i];
  }

  await changeText(languageProvider.getLocal, context);
}
