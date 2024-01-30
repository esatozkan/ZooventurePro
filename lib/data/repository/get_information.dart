import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/in_app_purchase_provider.dart';

import '/data/services/animal_service.dart';
import '/data/repository/generate_animal.dart';
import 'generate_text.dart';
import 'set_flag_image.dart';

void getInformation(context) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);
  generateFreeAnimal();
  generateBuy24Animal();
  generateBuy36Animal();
  if (inAppPurchaseProvider.getIsPremiumSubscribed) {
    freeAnimals.addAll(buy24Animals);
    freeAnimals.addAll(buy36Animals);
  } else {
    if (inAppPurchaseProvider.getIsBuy24AnimalSubscribed) {
      freeAnimals.addAll(buy24Animals);
    }
    if (inAppPurchaseProvider.getIsBuy36AnimalSubscribed) {
      freeAnimals.addAll(buy36Animals);
    }
  }

  generateText();
  setFlagImage(context);
}
