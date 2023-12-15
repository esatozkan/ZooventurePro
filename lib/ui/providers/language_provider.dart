import 'dart:io';
import 'package:flutter/foundation.dart';
import '/data/repository/game_control_repository.dart';

class LanguageProvider extends ChangeNotifier {
  String local = Platform.localeName.split("_")[0];
  List<String> languageService = [];
  List<Uint8List> languageServiceImage = [];
  int flagIndex = -1;

  String get getLocal => local;
  List<String> get getLanguageService => languageService;
  List<Uint8List> get getLanguageServiceImage => languageServiceImage;
  int get getFlagIndex => flagIndex;

  void chanceLocal() {
    int startIndex = languageService[flagIndex].indexOf('flag-images%2F');
    int endIndex = languageService[flagIndex].indexOf('.png');
    local = languageService[flagIndex].substring(startIndex + 14, endIndex);
    notifyListeners();
  }

  GameControlRepository languageRepository = GameControlRepository();

  void setFlagIndex(int val) {
    flagIndex = languageRepository.setIndex(val);
  }
}
