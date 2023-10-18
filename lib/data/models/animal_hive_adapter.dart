import 'package:hive/hive.dart';
import '/data/models/animal_hive_model.dart';

class AnimalHiveAdapter extends TypeAdapter<AnimalHiveModel> {
  @override
  final typeId = 0;

  @override
  AnimalHiveModel read(BinaryReader reader) {
    return AnimalHiveModel(
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, AnimalHiveModel obj) {
    writer.write(obj.name);
    writer.write(obj.voice);
    writer.write(obj.gif);
    writer.write(obj.image);
    writer.write(obj.realImage);
  }
}
