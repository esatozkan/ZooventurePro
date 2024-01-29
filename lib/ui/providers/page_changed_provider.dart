import 'package:flutter/material.dart';

class PageChangedProvider extends ChangeNotifier {
  int pageChanged = 0;
  int flagIndex = -1;

  int get getPageChanged => pageChanged;
  int get getFlagIndex => flagIndex;

  void pageChangedFunction(int val) {
    pageChanged = val;
    notifyListeners();
  }

  void setFlagIndex(int value) {
    flagIndex = value;
  }
}
