import '/data/repository/game_control_repository.dart';
import '/data/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalProvider with ChangeNotifier {
  List<String> animalNames = [];
  List<String> animalGif = [];
  List<String> animalVirtualImages = [];
  List<String> animalRealImage = [];
  List<String> animalVoices = [];
  List<String> uiTexts = [];
  List<Animal> animals = [];

  bool changeText = false;

  List<String> get getAnimalNames => animalNames;
  List<String> get getAnimalGif => animalGif;
  List<String> get getAnimalVirtualImage => animalVirtualImages;
  List<String> get getAnimalRealImage => animalRealImage;
  List<String> get getAnimalVoices => animalVoices;
  List<String> get getUiTexts => uiTexts;
  List<Animal> get getAnimals => animals;

  bool get getChangeText => changeText;

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

  void trueTextFunction() {
    changeText = gameControlRepository.trueOption(changeText);
    notifyListeners();
  }

  void falseTextFunction() {
    changeText = gameControlRepository.falseOption(changeText);
  }
}
