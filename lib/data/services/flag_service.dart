import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../ui/providers/animal_provider.dart';
import '../../ui/providers/language_provider.dart';

Box flagBox = Hive.box("flags");

getFlags(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);

  if (flagBox.isEmpty) {
    int i = 0;
    final storageRef = FirebaseStorage.instance.ref().child("flag-images");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      animalProvider.addInformation(
          languageProvider.getLanguageService, await element.getDownloadURL());
      flagBox.put(i, await element.getDownloadURL());
      i++;
    }
  } else {
    for (var element in flagBox.values) {
      animalProvider.addInformation(
          languageProvider.getLanguageService, element);
    }
  }
}
