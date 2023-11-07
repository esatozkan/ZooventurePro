// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Animal {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String voice;

  @HiveField(2)
  late String image;

  @HiveField(3)
  late String realImage;

  Animal({
    required this.name,
    required this.voice,
    required this.image,
    required this.realImage,
  });
}
