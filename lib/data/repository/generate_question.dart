import 'dart:math';
import '/data/services/question_service.dart';
import '../models/question_model.dart';

List<QuestionModel> questions = [];
List<QuestionModel> typeQuestions = [];
List<QuestionModel> realImageQuestions = [];
List<QuestionModel> virtualImageQuestions = [];

void generateQuestions(String whichGame, int questionLength, context) {
  
  if (whichGame == "knowWhatHear") {
    for (int i = 0; i < questionLength; i++) {
      questions.add(addQuestion(whichGame, context, i));
    }

    questions.shuffle(Random());
  } else if (whichGame == "knowWhatTypeAnimal") {
    for (int i = 0; i < questionLength; i++) {
      typeQuestions.add(addQuestion(whichGame, context, i));
    }

    typeQuestions.shuffle(Random());
  } else if (whichGame == "knowWhatRealAnimalImage") {
    for (int i = 0; i < questionLength; i++) {
      realImageQuestions.add(addQuestion(whichGame, context, i));
    }
    realImageQuestions.shuffle(Random());
  } else if (whichGame == "knowWhatVirtualAnimalImage") {
    for (int i = 0; i < questionLength; i++) {
      virtualImageQuestions.add(addQuestion(whichGame, context, i));
    }
    virtualImageQuestions.shuffle(Random());
  }
}

void clearQuestions() {
  questions.clear();
  typeQuestions.clear();
  realImageQuestions.clear();
  virtualImageQuestions.clear();
}
