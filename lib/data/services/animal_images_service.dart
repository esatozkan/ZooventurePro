import 'package:provider/provider.dart';
import '../../ui/providers/animal_provider.dart';

List<String> animalGifs = [
  "assets/animals/animal-gifs/bear.gif",
  "assets/animals/animal-gifs/bee.gif",
  "assets/animals/animal-gifs/bird.gif",
  "assets/animals/animal-gifs/bug.gif",
  "assets/animals/animal-gifs/cat.gif",
  "assets/animals/animal-gifs/cock.gif",
  "assets/animals/animal-gifs/cow.gif",
  "assets/animals/animal-gifs/dog.gif",
  "assets/animals/animal-gifs/dolphin.gif",
  "assets/animals/animal-gifs/donkey.gif",
  "assets/animals/animal-gifs/duck.gif",
  "assets/animals/animal-gifs/elephant.gif",
  "assets/animals/animal-gifs/fox.gif",
  "assets/animals/animal-gifs/frog.gif",
  "assets/animals/animal-gifs/horse.gif",
  "assets/animals/animal-gifs/lion.gif",
  "assets/animals/animal-gifs/monkey.gif",
  "assets/animals/animal-gifs/mouse.gif",
  "assets/animals/animal-gifs/penguin.gif",
  "assets/animals/animal-gifs/snake.gif",
  "assets/animals/animal-gifs/squirrel.gif",
  "assets/animals/animal-gifs/turkey.gif",
  "assets/animals/animal-gifs/woolf.gif",
  "assets/animals/animal-gifs/zebra.gif",
];

List<String> animalRealImages = [
  "assets/animals/animal-real-images/bear_real.png",
  "assets/animals/animal-real-images/bee_real.png",
  "assets/animals/animal-real-images/bird_real.png",
  "assets/animals/animal-real-images/bug_real.png",
  "assets/animals/animal-real-images/cat_real.png",
  "assets/animals/animal-real-images/cock_real.png",
  "assets/animals/animal-real-images/cow_real.png",
  "assets/animals/animal-real-images/dog_real.png",
  "assets/animals/animal-real-images/dolphin_real.png",
  "assets/animals/animal-real-images/donkey_real.png",
  "assets/animals/animal-real-images/duck_real.png",
  "assets/animals/animal-real-images/elephant_real.png",
  "assets/animals/animal-real-images/fox_real.png",
  "assets/animals/animal-real-images/frog_real.png",
  "assets/animals/animal-real-images/horse_real.png",
  "assets/animals/animal-real-images/lion_real.png",
  "assets/animals/animal-real-images/monkey_real.png",
  "assets/animals/animal-real-images/mouse_real.png",
  "assets/animals/animal-real-images/penguin_real.png",
  "assets/animals/animal-real-images/snake_real.png",
  "assets/animals/animal-real-images/squirrel_real.png",
  "assets/animals/animal-real-images/turkey_real.png",
  "assets/animals/animal-real-images/woolf_real.png",
  "assets/animals/animal-real-images/zebra_real.png",
];

List<String> animalVirtualImages = [
  "assets/animals/animal-virtual-images/bear.png",
  "assets/animals/animal-virtual-images/bee.png",
  "assets/animals/animal-virtual-images/bird.png",
  "assets/animals/animal-virtual-images/bug.png",
  "assets/animals/animal-virtual-images/cat.png",
  "assets/animals/animal-virtual-images/cock.png",
  "assets/animals/animal-virtual-images/cow.png",
  "assets/animals/animal-virtual-images/dog.png",
  "assets/animals/animal-virtual-images/dolphin.png",
  "assets/animals/animal-virtual-images/donkey.png",
  "assets/animals/animal-virtual-images/duck.png",
  "assets/animals/animal-virtual-images/elephant.png",
  "assets/animals/animal-virtual-images/fox.png",
  "assets/animals/animal-virtual-images/frog.png",
  "assets/animals/animal-virtual-images/horse.png",
  "assets/animals/animal-virtual-images/lion.png",
  "assets/animals/animal-virtual-images/monkey.png",
  "assets/animals/animal-virtual-images/mouse.png",
  "assets/animals/animal-virtual-images/penguin.png",
  "assets/animals/animal-virtual-images/snake.png",
  "assets/animals/animal-virtual-images/squirrel.png",
  "assets/animals/animal-virtual-images/turkey.png",
  "assets/animals/animal-virtual-images/woolf.png",
  "assets/animals/animal-virtual-images/zebra.png",
];

void addAnimalImages(context) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  for (int i = 0; i < animalGifs.length; i++) {
    animalProvider.addInformation(
      animalProvider.getAnimalGif,
      animalGifs[i],
    );
    animalProvider.addInformation(
      animalProvider.getAnimalRealImage,
      animalRealImages[i],
    );
    animalProvider.addInformation(
      animalProvider.getAnimalVirtualImage,
      animalVirtualImages[i],
    );
  }
}
