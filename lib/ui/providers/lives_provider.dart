import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LivesProvider extends ChangeNotifier {
  // int live=Hive.box("lives").get("live")??5;
  int remainingMinutes = 19;
  int remainingSeconds = 59;
  late String remainingMinutesToString;
  late String remainingSecondsToString;
  int live = 0;

  int get getLive => live;
  String get getRemainingMinutes => remainingMinutesToString;
  String get getRemainingSeconds => remainingSecondsToString;

  void decrementLive() {
    live--;
    Hive.box("lives").put("live", live);
    Hive.box("lives").put("endTime", DateTime.now());
    startCountDown();
    notifyListeners();
  }

  void incrementLive() {
    live++;
    Hive.box("lives").put("live", live);
    if (live != 5) {
      startCountDown();
    }
    notifyListeners();
  }

  void startCountDown() {
    if (live != 5) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingMinutes == 0 && remainingSeconds == 0) {
          timer.cancel();
          incrementLive();
          remainingMinutes = 19;
          remainingSeconds = 59;
          notifyListeners();
        } else {
          if (remainingSeconds == 0) {
            remainingMinutes--;
            remainingSeconds = 59;
          } else {
            remainingSeconds--;
          }
          notifyListeners();
        }
        remainingMinutesToString = remainingMinutes.toString().padLeft(2, "0");
        remainingSecondsToString = remainingSeconds.toString().padLeft(2, "0");
      });
    }
  }
}
