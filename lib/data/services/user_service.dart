import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../models/user_model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

getUserInformation(context) async {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);

  inAppPurchaseProvider.setGemsValue(0);

  if (auth.currentUser == null) {
    await createUserInformationData(context);
  } else {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      inAppPurchaseProvider.setGemsValue(data["gems"]);
    }
  }
}

// setUserInformation(String key, dynamic value) async {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   final firebaseFirestore =
//       FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid);

//   await firebaseFirestore.set(
//     {
//       key: value,
//     },
//   );
// }

createUserInformationData(context) async {
    InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);

  await signInWithGoogle();

  if (auth.currentUser != null) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();
    if (snapshot != null) {
          if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      inAppPurchaseProvider.setGemsValue(data["gems"]);
    }
    } else {
      final firebaseFirestore = FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid);
      await firebaseFirestore.set({
        "gems": 0,
        "buy 24 animals": false,
        "buy 36 animals": false,
      });
    }
  }
}
