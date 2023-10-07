import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';

getText(String local, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DocumentSnapshot snapshot =
      await firebaseFirestore.collection("languages").doc(local).get();

  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    data.forEach(
      (key, value) {
        animalProvider.addInformation(
          animalProvider.getUiTexts,
          value,
        );
      },
    );
  } else {
    snapshot = await firebaseFirestore.collection("languages").doc("en").get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    data.forEach(
      (key, value) {
        animalProvider.addInformation(
          animalProvider.getUiTexts,
          value,
        );
      },
    );
  }
}
