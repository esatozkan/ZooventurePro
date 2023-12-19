import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LivesProvider extends ChangeNotifier {
  //int live = Hive.box("lives").get("live") ?? 5;
  int live = 5;
  int remainingMinutes = 19;
  int remainingSeconds = 59;
  int minutes = Hive.box("lives").get("minutes") ?? 19;
  int seconds = Hive.box("lives").get("seconds") ?? 59;
  String remainingMinutesToString = "";
  String remainingSecondsToString = "";
  DateTime deadline =
      Hive.box<DateTime>("timer").get("timer") ?? DateTime.now();
  DateTime now = DateTime.now();
  int get getLive => live;
  String get getRemainingMinutes => remainingMinutesToString;
  String get getRemainingSeconds => remainingSecondsToString;

  void decrementLive() {
    live--;
    Hive.box("lives").put("live", live);
    if (live == 4) {
      startCountDown();
    }

    notifyListeners();
  }

  void incrementLive() {
    live++;
    Hive.box("lives").put("live", live);
    if (live < 5) {
      startCountDown();
    }
    notifyListeners();
  }

  void setLive(int value) {
    live = value;
    Hive.box("lives").put("live", live);
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

            Hive.box<DateTime>("timer").put("timer", DateTime.now());
            Hive.box("lives").put("minutes", remainingMinutes);
          } else {
            remainingSeconds--;

            Hive.box<DateTime>("timer").put("timer", DateTime.now());
            Hive.box("lives").put("seconds", remainingSeconds);
          }
          notifyListeners();
        }
        remainingMinutesToString = remainingMinutes.toString().padLeft(2, "0");
        remainingSecondsToString = remainingSeconds.toString().padLeft(2, "0");
      });
    }
  }

  void determineLive() {
    live = (live + now.difference(deadline).inMinutes ~/ 20) > 5
        ? 5
        : live + now.difference(deadline).inMinutes ~/ 20;

    if (live != 5) {
      final minuteLeft = now.difference(deadline).inMinutes % 20;
      remainingSeconds = seconds;
      if (minutes > minuteLeft) {
        remainingMinutes = minutes - minuteLeft;
        startCountDown();
      } else if (minutes < minuteLeft) {
        live++;
        if (live != 5) {
          remainingMinutes = 19 + minutes - minuteLeft;
          startCountDown();
        } else {
          remainingMinutes = 19;
          remainingSeconds = 59;
        }
      } else {
        live++;
        remainingMinutes = 19;
        remainingSeconds = 59;
        startCountDown();
      }
    }
  }
}
