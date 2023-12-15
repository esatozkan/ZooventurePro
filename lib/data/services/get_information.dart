import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '/data/services/user_service.dart';
import '../../ui/providers/in_app_purchase_provider.dart';
import '../../ui/providers/language_provider.dart';
import '../models/animal_model.dart';
import '../repository/generate_animal.dart';
import 'animal_service.dart';
import 'flag_service.dart';
import 'language_service.dart';
import 'text_services.dart';

Future getSomeInformation(context) async {
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);

  Box animalBox = Hive.box<Animal>("animals");

  getUserInformation(context);

  await inAppPurchaseProvider.getProducts();
  inAppPurchaseProvider.getIApEngine.inAppPurchase.purchaseStream
      .listen((list) {
    inAppPurchaseProvider.listenPurchases(list, context);
  });

  if (animalBox.length != 24) {
    animalBox.clear();
    await getAnimalVirtualImage(context);
  }

  await getText(
    languageProvider.getLocal,
    context,
  );
}

Future getAllInformation(context) async {
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);

  Box animalBox = Hive.box<Animal>("animals");
  Box animal24Box = Hive.box<Animal>("buy24animals");
  Box animal36Box = Hive.box<Animal>("buy36animals");

  if (animalBox.length != 24) {
    animalBox.clear();
    await getAnimalName(languageProvider.getLocal, context);
    await getAnimalVoice(context);
    await getAnimalRealImage(context);
  }

  await getFlags(context);

  getLanguageFlag(
    languageProvider.getLocal,
    context,
  );

  generateAnimal(context, languageProvider.getLocal);

  if (animal24Box.length != 24) {
    await getAnimalVirtualImage(context, animalType: 24);
    await getAnimalRealImage(context, animalType: 24);
    await getAnimalName(languageProvider.getLocal, context, animalType: 24);
    await getAnimalVoice(context, animalType: 24);

    generateBuyAnimal(24);
  }

  inAppPurchaseProvider.is24AnimalsDownloadFunction(true);

  if (animal36Box.isEmpty) {
    await getAnimalVirtualImage(context, animalType: 36);
    await getAnimalRealImage(context, animalType: 36);
    await getAnimalName(languageProvider.getLocal, context, animalType: 36);
    await getAnimalVoice(context, animalType: 36);

    generateBuyAnimal(36);
  }

  inAppPurchaseProvider.is36AnimalsDownloadFunction(true);
}
