import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../models/user_model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

getUserInformation(context) async {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);

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

      inAppPurchaseProvider.setIs24Animal(data["buy 24 animals"]);
      inAppPurchaseProvider.setIs36Animal(data["buy 36 animals"]);
      inAppPurchaseProvider.setGemsValue(data["gems"]);
    }
  }
}

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
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      inAppPurchaseProvider.setIs24Animal(data["buy 24 animals"]);
      inAppPurchaseProvider.setIs36Animal(data["buy 36 animals"]);
      inAppPurchaseProvider.setGemsValue(data["gems"]);
    } else {
      final firebaseFirestore = FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid);
      await firebaseFirestore.set({
        "gems": 0,
        "buy 24 animals": false,
        "buy 36 animals": false,
      });
      inAppPurchaseProvider.setIs24Animal(false);
      inAppPurchaseProvider.setIs36Animal(false);
      inAppPurchaseProvider.setGemsValue(0);
    }
  }
}
