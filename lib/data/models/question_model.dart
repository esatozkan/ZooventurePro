// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/data/models/animal_model.dart';

class QuestionAnswerModel {
  late Animal question;
  late Map<Animal, bool> option;

  QuestionAnswerModel({
    required this.question,
    required this.option,
  });
}
