import 'dart:io';
import '../services/text_services.dart';

void generateText() {
  Platform.localeName.split("_")[0] == "tr"
      ? texts.addAll(textTr)
      : Platform.localeName.split("_")[0] == "hi"
          ? texts.addAll(textHi)
          : Platform.localeName.split("_")[0] == "de"
              ? texts.addAll(textDe)
              : Platform.localeName.split("_")[0] == "it"
                  ? texts.addAll(textIt)
                  : Platform.localeName.split("_")[0] == "id"
                      ? texts.addAll(textId)
                      : texts.addAll(textEn);
}
