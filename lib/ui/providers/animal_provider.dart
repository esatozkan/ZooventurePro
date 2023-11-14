import '/data/repository/game_control_repository.dart';
import '/data/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalProvider with ChangeNotifier {
  List<String> uiTexts = [];
  List<Animal> animals = [];
  bool isAllInformationDownload = false;

  List<String> get getUiTexts => uiTexts;
  List<Animal> get getAnimals => animals;
  bool get getIsAllInformationDownload => isAllInformationDownload;

  GameControlRepository gameControlRepository = GameControlRepository();

  void addAnimal(Animal animal) {
    animals.add(animal);
  }

  void addInformation(List list, dynamic information) {
    list.add(information);
  }

  void clearList(List list) {
    list.clear();
  }

  void updateText(String newText, int index) {
    uiTexts[index] = newText;
    notifyListeners();
  }

  void isAllAnimalDownloadFunction(bool val) {
    isAllInformationDownload = val;
    notifyListeners();
  }
}
