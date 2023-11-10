// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Animal {
  @HiveField(0)
  late Uint8List name;

  @HiveField(1)
  late Uint8List voice;

  @HiveField(2)
  late Uint8List image;

  @HiveField(3)
  late Uint8List realImage;

  @HiveField(4)
  late String spelling;

  Animal({
    required this.name,
    required this.voice,
    required this.image,
    required this.realImage,
    required this.spelling,
  });
}
