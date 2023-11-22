import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

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
    final imageUrl = await element.getData();
    final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
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
    final response = await element.getData();
    final Uint8List imageBytes = Uint8List.fromList(response as List<int>);

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
    final imageUrl = await element.getData();
    final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
    animalNames.add(imageBytes);
  }

  if (animalNames.isEmpty) {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("free-animals/animal-types/animal-type-en");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      final imageUrl = await element.getData();
      final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
      animalNames.add(imageBytes);
    }
  }
}

getAnimalVoice(context) async {
  final storageRef =
      FirebaseStorage.instance.ref().child("free-animals/animal-voices");

  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    final imageUrl = await element.getData();
    final Uint8List imageBytes = Uint8List.fromList(imageUrl as List<int>);
    animalVoices.add(imageBytes);
  }
}

