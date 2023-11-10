import 'dart:typed_data';
import 'package:http/http.dart' as http;
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

  final storageRef = FirebaseStorage.instance.ref().child("flag-images");
  final listResult = await storageRef.listAll();

  if (flagBox.length != listResult.items.length) {
    flagBox.clear();
    int i = 0;

    for (var element in listResult.items) {
      final imageUrl = await element.getDownloadURL();
      final response = await http.get(Uri.parse(imageUrl));
      final Uint8List imageBytes = response.bodyBytes;

      animalProvider.addInformation(
        languageProvider.getLanguageServiceImage,
        imageBytes,
      );

      animalProvider.addInformation(
        languageProvider.getLanguageService,
        imageUrl,
      );
      flagBox.put(i, imageUrl);
      i++;
    }
  } else {
    for (var element in flagBox.values) {
      final response = await http.get(Uri.parse(element));
      final Uint8List imageBytes = response.bodyBytes;
      animalProvider.addInformation(
        languageProvider.getLanguageService,
        element,
      );
      animalProvider.addInformation(
        languageProvider.getLanguageServiceImage,
        imageBytes,
      );
    }
  }
}
