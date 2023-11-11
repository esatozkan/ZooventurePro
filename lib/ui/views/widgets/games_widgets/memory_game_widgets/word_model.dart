import 'dart:typed_data';

class WordModel {
  final String text;
  final Uint8List url;
  bool displayText;

  WordModel({
    required this.text,
    required this.url,
    required this.displayText,
  });
}
