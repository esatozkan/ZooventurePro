import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '/ui/providers/language_provider.dart';
import '/ui/providers/animal_provider.dart';

getAnimalInformation(List list, String path, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  final storageRef = FirebaseStorage.instance.ref().child(path);
  final listResult = await storageRef.listAll();
  for (var element in listResult.items) {
    animalProvider.addInformation(list, await element.getDownloadURL());
  }
}

getAnimal(String local, context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);

  await getAnimalInformation(
    animalProvider.animalNames,
    "animal-types/animal-type-$local",
    context,
  );

  if (animalProvider.getAnimalNames.isEmpty) {
    await getAnimalInformation(
      animalProvider.getAnimalNames,
      "animal-types/animal-type-en",
      context,
    );
  }

  await getAnimalInformation(
    languageProvider.getLanguageService,
    "flag-images",
    context,
  );

  await getAnimalInformation(
    animalProvider.animalVoices,
    "animal-voices",
    context,
  );
}
