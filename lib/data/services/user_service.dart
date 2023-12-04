import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/in_app_purchase_provider.dart';

getUserInformation(context) async {
  final DatabaseReference database = FirebaseDatabase.instance.reference();
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);
  final FirebaseAuth auth = FirebaseAuth.instance;

  if (auth.currentUser != null) {
    DataSnapshot snapshot =
        await database.child("users").child(auth.currentUser!.uid).get();
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    inAppPurchaseProvider.setGemsValue(values!["gems"]);
  } else {}
}

setUserInformation() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  await ref.child("users").child(auth.currentUser!.uid).set({
    'gems': 0,
    'buy 24 animals': false,
    'buy 36 animals': false,
  });
}
