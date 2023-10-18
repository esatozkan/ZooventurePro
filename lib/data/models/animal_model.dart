// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Animal {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String voice;

  @HiveField(2)
  late String gif;

  @HiveField(3)
  late String image;

  @HiveField(4)
  late String realImage;

  @HiveField(11)
  late bool isVisible;

  @HiveField(12)
  late bool isCorrectAnswer;

  Animal({
    required this.name,
    required this.voice,
    required this.gif,
    required this.image,
    required this.realImage,
    required this.isVisible,
    required this.isCorrectAnswer,
  });
}
