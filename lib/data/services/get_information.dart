import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../ui/providers/animal_provider.dart';
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

  await inAppPurchaseProvider.getProducts();
  inAppPurchaseProvider.getIApEngine.inAppPurchase.purchaseStream
      .listen((list) {
    inAppPurchaseProvider.listenGemPurchases(list);
  });
inAppPurchaseProvider.getIApEngine.inAppPurchase.purchaseStream.listen((listOfPurchaseDetails) {
  inAppPurchaseProvider.listenRemoveAdSubscribe(listOfPurchaseDetails);

});

  if (animalBox.isEmpty) {
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
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);

  Box animalBox = Hive.box<Animal>("animals");

  if (animalBox.isEmpty) {
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

  animalProvider.isAllAnimalDownloadFunction(true);
}
