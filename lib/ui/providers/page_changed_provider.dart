import '/data/repository/game_control_repository.dart';
import 'package:flutter/material.dart';

class PageChangedProvider extends ChangeNotifier {
  int pageChanged = 0;

  get getPageChanged => pageChanged;

  GameControlRepository pageChangedRepository=GameControlRepository();


  void pageChangedFunction(int val){
    pageChanged=pageChangedRepository.setIndex(val);
    notifyListeners();
  }
  
}
