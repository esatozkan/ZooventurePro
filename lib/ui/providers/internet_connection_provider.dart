import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '/data/repository/internet_connection_repository.dart';

class InternetConnectionProvider with ChangeNotifier {
  late StreamSubscription streamSubscription;
  var isDeviceConnected = false;
  bool isAlert = false;

  get getStreamSubscription => streamSubscription;
  get getIsDeviceConnected => isDeviceConnected;
  bool get getIsAlert => isAlert;

  var internetConnectionRepo = InternetConnectionRepository();

  void internetOn() {
    internetConnectionRepo.internetOn(isAlert);
    notifyListeners();
  }

  void internetOff() {
    internetConnectionRepo.internetOff(isAlert);
    notifyListeners();
  }

  void internetConnectionChecker() async {
    internetConnectionRepo.isInternetConnectionChecker(isDeviceConnected);
    notifyListeners();
  }

  StreamSubscription getConnectivity(context) {
    streamSubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
      },
    );
    return streamSubscription;
  }
}
