import '/data/repository/game_control_repository.dart';
import '/data/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalProvider with ChangeNotifier {
  List<String> uiTexts = [];
  List<Animal> animals = [];

  List<String> get getUiTexts => uiTexts;
  List<Animal> get getAnimals => animals;

  GameControlRepository gameControlRepository = GameControlRepository();

  void addAnimal(Animal animal) {
    animals.add(animal);
  }

  void addInformation(List list, String information) {
    list.add(information);
  }

  void clearList(List list) {
    list.clear();
  }

  void updateText(String newText, int index) {
    uiTexts[index] = newText;
    notifyListeners();
  }
}
