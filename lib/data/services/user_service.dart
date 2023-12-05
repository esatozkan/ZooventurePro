import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:onepref/onepref.dart';
import 'package:provider/provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../models/user_model.dart';

getUserInformation(context) async {
  final DatabaseReference database = FirebaseDatabase.instance.reference();
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);
  final FirebaseAuth auth = FirebaseAuth.instance;
  var connectivityResult = await Connectivity().checkConnectivity();

  if (auth.currentUser != null) {
    if (connectivityResult == ConnectivityResult.none) {
      inAppPurchaseProvider.setGemsValue(OnePref.getInt("gems") ?? 0);
    } else {
      DataSnapshot snapshot =
          await database.child("users").child(auth.currentUser!.uid).get();
      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

      if (values!["gems"] > OnePref.getInt("gems")) {
        inAppPurchaseProvider.setGemsValue(OnePref.getInt("gems") ?? 0);
        setUserInformation("gems", OnePref.getInt("gems"));
      } else {
        inAppPurchaseProvider.setGemsValue(values["gems"]);
      }
    }
  } else {
    inAppPurchaseProvider.setGemsValue(OnePref.getInt("gems") ?? 0);
  }
}

setUserInformation(String key, dynamic value) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Map<String, dynamic> updates = {};
  updates[key] = value;

  await ref.child("users").child(auth.currentUser!.uid).update(updates);
}

createUserInformationData() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  signInWithGoogle();
  if (auth.currentUser != null) {
    await ref.child("users").child(auth.currentUser!.uid).set({
      'gems': 0,
      'buy 24 animals': false,
      'buy 36 animals': false,
    });
  }
}
