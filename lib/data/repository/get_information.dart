import '/data/services/animal_service.dart';
import '/data/repository/generate_animal.dart';
import 'generate_text.dart';
import 'set_flag_image.dart';

void getInformation(context) {
  generateFreeAnimal();
  generateBuy24Animal();
  generateBuy36Animal();
  freeAnimals.addAll(buy24Animals);
  freeAnimals.addAll(buy36Animals);
  generateText();
  setFlagImage(context);
}
