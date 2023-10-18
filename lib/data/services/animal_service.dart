import 'package:firebase_storage/firebase_storage.dart';

List<String> animalNames = [];
List<String> animalGif = [];
List<String> animalVirtualImages = [];
List<String> animalRealImage = [];
List<String> animalVoices = [];

getAnimalGif(context) async {
  final storageRef =
      FirebaseStorage.instance.ref().child("animal-images/animal-gifs");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalGif.add(await element.getDownloadURL());
  }
}

getAnimalRealImage(context) async {
  final storageRef =
      FirebaseStorage.instance.ref().child("animal-images/animal-real-images");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalRealImage.add(await element.getDownloadURL());
  }
}

getAnimalVirtualImage(context) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child("animal-images/animal-virtual-images");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalVirtualImages.add(await element.getDownloadURL());
  }
}

getAnimalName(String local, context) async {
  final storageRef =
      FirebaseStorage.instance.ref().child("animal-types/animal-type-$local");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalNames.add(await element.getDownloadURL());
  }

  if (animalNames.isEmpty) {
    final storageRef =
        FirebaseStorage.instance.ref().child("animal-types/animal-type-en");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      animalNames.add(await element.getDownloadURL());
    }
  }
}

getAnimalVoice(context) async {
  final storageRef = FirebaseStorage.instance.ref().child("animal-voices");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalVoices.add(await element.getDownloadURL());
  }
}
