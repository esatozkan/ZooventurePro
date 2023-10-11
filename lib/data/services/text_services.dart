import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';

Box languageBox = Hive.box("languages");

getText(String local, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  int i = 0;

  if (languageBox.isEmpty) {
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
          languageBox.put(i, value);
          i++;
        },
      );
    } else {
      snapshot =
          await firebaseFirestore.collection("languages").doc("en").get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      data.forEach(
        (key, value) {
          animalProvider.addInformation(
            animalProvider.getUiTexts,
            value,
          );
          languageBox.put(i, value);
          i++;
        },
      );
    }
  } else {
    for (int i = 0; i < languageBox.length; i++) {
      animalProvider.addInformation(
          animalProvider.getUiTexts, languageBox.get(i));
    }
  }
}

changeText(String local, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DocumentSnapshot snapshot =
      await firebaseFirestore.collection("languages").doc(local).get();

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
