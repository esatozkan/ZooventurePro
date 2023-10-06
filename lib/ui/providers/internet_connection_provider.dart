import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';
import '../../data/constans/constans.dart';
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
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    streamSubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlert == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: itemColor,
              content: Center(
                child: Text(
                  animalProvider.getUiTexts[9],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
          internetOn();
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
    );
    return streamSubscription;
  }
}
