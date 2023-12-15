import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';

Box languageBox = Hive.box<Map<dynamic, dynamic>>("languages");

getText(String local, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  languageBox.clear();

  if (languageBox.isEmpty) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // DocumentSnapshot snapshot =
    //     await firebaseFirestore.collection("languages").doc(local).get();
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("languages").doc("deneme").get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.data() as Map<dynamic, dynamic>;
      animalProvider.setTextToMap(data);
      languageBox.put("languages", data);
    } else {
      snapshot =
          await firebaseFirestore.collection("languages").doc("en").get();
      animalProvider.setTextToMap(snapshot.data() as Map<dynamic, dynamic>);
      languageBox.put("languages", snapshot.data() as Map<dynamic, dynamic>);
    }
  } else {
    animalProvider.setTextToMap(languageBox.get("languages"));
  }
}

changeText(String local, context) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DocumentSnapshot snapshot =
      await firebaseFirestore.collection("languages").doc(local).get();

  Provider.of<AnimalProvider>(context, listen: false)
      .setTextToMap(snapshot.data() as Map<dynamic, dynamic>);
}
