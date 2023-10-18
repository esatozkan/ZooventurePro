import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';

getAnimalGif(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  final storageRef =
      FirebaseStorage.instance.ref().child("animal-images/animal-gifs");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalProvider.addInformation(
        animalProvider.getAnimalGif, await element.getDownloadURL());
  }
}

getAnimalRealImage(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  final storageRef =
      FirebaseStorage.instance.ref().child("animal-images/animal-real-images");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalProvider.addInformation(
        animalProvider.getAnimalRealImage, await element.getDownloadURL());
  }
}

getAnimalVirtualImage(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  final storageRef = FirebaseStorage.instance
      .ref()
      .child("animal-images/animal-virtual-images");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalProvider.addInformation(
        animalProvider.getAnimalVirtualImage, await element.getDownloadURL());
  }
}

getAnimalName(String local, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  final storageRef =
      FirebaseStorage.instance.ref().child("animal-types/animal-type-$local");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalProvider.addInformation(
        animalProvider.animalNames, await element.getDownloadURL());
  }

  if (animalProvider.getAnimalNames.isEmpty) {
    final storageRef =
        FirebaseStorage.instance.ref().child("animal-types/animal-type-en");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      animalProvider.addInformation(
          animalProvider.animalNames, await element.getDownloadURL());
    }
  }
}

getAnimalVoice(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  final storageRef = FirebaseStorage.instance.ref().child("animal-voices");
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalProvider.addInformation(
        animalProvider.animalVoices, await element.getDownloadURL());
  }
}
