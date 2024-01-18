import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
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
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);
  List<Uint8List> getUrls = [];

  animalProvider.clearList(animalProvider.getUiTexts);
  languageProvider.chanceLocal();

  final storageRef = FirebaseStorage.instance.ref().child(
      "free-animals/animal-types/animal-type-${languageProvider.getLocal}");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    final imageUrl = await element.getData();
    final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
    getUrls.add(imageBytes);
  }

  if (inAppPurchaseProvider.getIsBuy24AnimalSubscribed) {
    final storageRef = FirebaseStorage.instance.ref().child(
        "buy-24-animals/animal-types/animal-type-${languageProvider.getLocal}");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      final imageUrl = await element.getData();
      final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
      getUrls.add(imageBytes);
    }
  }

  if (inAppPurchaseProvider.getIsBuy36AnimalSubscribed) {
    final storageRef = FirebaseStorage.instance.ref().child(
        "buy-36-animals/animal-types/animal-type-${languageProvider.getLocal}");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      final imageUrl = await element.getData();
      final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
      getUrls.add(imageBytes);
    }
  }

  for (int i = 0; i < animalProvider.getAnimals.length; i++) {
    animalProvider.getAnimals[i].name = getUrls[i];
  }

  await changeText(languageProvider.getLocal, context);
}
