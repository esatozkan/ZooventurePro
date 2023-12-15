import 'package:cloud_firestore/cloud_firestore.dart';

Future applicationData(String dataItem) async {
  final firebaseFirestore =
      FirebaseFirestore.instance.collection("application-data").doc("datas");

  await firebaseFirestore.update(
    {
      dataItem: FieldValue.increment(1),
    },
  );
}
