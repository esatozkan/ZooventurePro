import '/data/repository/game_control_repository.dart';
import '/data/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalProvider with ChangeNotifier {
  Map<dynamic, dynamic> uiTexts = {};
  List<Animal> animals = [];
  bool isAllInformationDownload = false;

  Map<dynamic, dynamic> get getUiTexts => uiTexts;
  List<Animal> get getAnimals => animals;
  bool get getIsAllInformationDownload => isAllInformationDownload;

  GameControlRepository gameControlRepository = GameControlRepository();

  void addAnimal(Animal animal) {
    animals.add(animal);
  }

  void addInformation(List list, dynamic information) {
    list.add(information);
  }

  void clearList(Map<dynamic, dynamic> map) {
    map.clear();
  }

  void setTextToMap(Map<dynamic, dynamic> map) {
    uiTexts = map;
    notifyListeners();
  }

  void isAllAnimalDownloadFunction(bool val) {
    isAllInformationDownload = val;
    notifyListeners();
  }
}
