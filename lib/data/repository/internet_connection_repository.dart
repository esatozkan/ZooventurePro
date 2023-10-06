import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionRepository {
  bool internetOn(bool value) {
    value = true;
    return value;
  }

  bool internetOff(bool value) {
    value = false;
    return value;
  }

  Future<bool> isInternetConnectionChecker(bool value) async {
    value = await InternetConnectionChecker().hasConnection;
    return value;
  }
}
