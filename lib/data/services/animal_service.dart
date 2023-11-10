import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

List<Uint8List> animalNames = [];
List<Uint8List> animalVirtualImages = [];
List<Uint8List> animalRealImage = [];
List<Uint8List> animalVoices = [];
List<String> animalSpelling = [];

getAnimalRealImage(context) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child("free-animals/animal-images/animal-real-images");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    final imageUrl = await element.getDownloadURL();
    final response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = response.bodyBytes;
    animalRealImage.add(imageBytes);
  }
}

getAnimalVirtualImage(context) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child("free-animals/animal-images/animal-virtual-images");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    final imageUrl = await element.getDownloadURL();
    final response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = response.bodyBytes;

    int startIndex = imageUrl.indexOf('animal-virtual-images%2F');
    int endIndex = imageUrl.indexOf('.png');
    String name = imageUrl.substring(startIndex + 24, endIndex);
    animalSpelling.add(name);
    animalVirtualImages.add(imageBytes);
  }
}

getAnimalName(String local, context) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child("free-animals/animal-types/animal-type-$local");

  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    final imageUrl = await element.getDownloadURL();
    final response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = response.bodyBytes;
    animalNames.add(imageBytes);
  }

  if (animalNames.isEmpty) {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("free-animals/animal-types/animal-type-en");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      final imageUrl = await element.getDownloadURL();
      final response = await http.get(Uri.parse(imageUrl));
      final Uint8List imageBytes = response.bodyBytes;
      animalNames.add(imageBytes);
    }
  }
}

getAnimalVoice(context) async {
  final storageRef =
      FirebaseStorage.instance.ref().child("free-animals/animal-voices");

  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    final imageUrl = await element.getDownloadURL();
    final response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = response.bodyBytes;
    animalVoices.add(imageBytes);
  }
}
