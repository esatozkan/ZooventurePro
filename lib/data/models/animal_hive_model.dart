// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class AnimalHiveModel {
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

  @HiveField(5)
  late bool isVisible;

  @HiveField(6)
  late bool isCorrectAnswer;

  AnimalHiveModel(
    this.name,
    this.voice,
    this.gif,
    this.image,
    this.realImage,
    this.isVisible,
    this.isCorrectAnswer,
  );
}
