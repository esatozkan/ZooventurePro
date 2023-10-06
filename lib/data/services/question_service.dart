import 'dart:math';
import '/data/models/question_model.dart';
import '/ui/providers/animal_provider.dart';
import 'package:provider/provider.dart';

QuestionModel addQuestion(String whichGame, context, index) {
  AnimalProvider animalProvider = Provider.of<AnimalProvider>(context);

  List<int> generatedRandomNumbers = [];

  QuestionModel question = QuestionModel();

  if (whichGame == "knowWhatHear") {
    question.animalVoice = animalProvider.animals[index].voice;
  } else if (whichGame == "knowWhatTypeAnimal") {
    question.animalVoice = animalProvider.animals[index].name;
  } else if (whichGame == "knowWhatRealAnimalImage") {
    question.animalVoice = animalProvider.animals[index].realImage;
  } else if (whichGame == "knowWhatVirtualAnimalImage") {
    question.animalVoice = animalProvider.animals[index].image;
  }

  generatedRandomNumbers.add(index);

  while (generatedRandomNumbers.length < 4) {
    int generatedRandomNumber;
    do {
      generatedRandomNumber = Random().nextInt(animalProvider.animals.length);
    } while (generatedRandomNumbers.contains(generatedRandomNumber));
    generatedRandomNumbers.add(generatedRandomNumber);
  }

  for (int i = 0; i < generatedRandomNumbers.length; i++) {
    question.option.add(animalProvider.animals[generatedRandomNumbers[i]]);
  }

  question.option.shuffle(Random());
  generatedRandomNumbers.clear();
  return question;
}
