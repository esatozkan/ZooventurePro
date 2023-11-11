import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../ui/providers/animal_provider.dart';
import '../../ui/providers/language_provider.dart';

Box flagBox = Hive.box("flags");
Box flagBoxSpelling = Hive.box("flagSpelling");

getFlags(context) async {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);

  if (flagBox.isEmpty) {
    final storageRef = FirebaseStorage.instance.ref().child("flag-images");
    final listResult = await storageRef.listAll();

    int i = 0;

    for (var element in listResult.items) {
      final imageUrl = await element.getDownloadURL();
      final response = await http.get(Uri.parse(imageUrl));
      final Uint8List imageBytes = response.bodyBytes;

      animalProvider.addInformation(
        languageProvider.getLanguageServiceImage,
        imageBytes,
      );
      flagBox.put(i, imageBytes);

      animalProvider.addInformation(
        languageProvider.getLanguageService,
        imageUrl,
      );
      flagBoxSpelling.put(i, imageUrl);
      i++;
    }
  } else {
    for (var element in flagBoxSpelling.values) {
      animalProvider.addInformation(
        languageProvider.getLanguageService,
        element,
      );
    }
    for (var element in flagBox.values) {
      animalProvider.addInformation(
        languageProvider.getLanguageServiceImage,
        element,
      );
    }
  }
}
