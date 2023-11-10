import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/services/application_data_service.dart';
import '../../../providers/animal_provider.dart';
import '../../../providers/page_changed_provider.dart';

class GridCardWidget extends StatefulWidget {
  const GridCardWidget({super.key});

  @override
  State<GridCardWidget> createState() => _GridCardWidgetState();
}

class _GridCardWidgetState extends State<GridCardWidget> {
  AudioPlayer voicePlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;

    AnimalProvider animalProvider = Provider.of<AnimalProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (size.width < 1100) ? 4 : 6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: animalProvider.getAnimals.length,
        itemBuilder: (BuildContext context, index) {
          return Consumer<AnimalProvider>(
            builder: (context, animalProvider, _) => GestureDetector(
              onTap: () async {
                pageChangedProvider.getPageChanged == 0
                    ? {
                        applicationData("Click Animal Name"),
                        await voicePlayer.play(
                          BytesSource(
                            animalProvider.getAnimals[index].name,
                          ),
                        ),
                      }
                    : {
                        applicationData("Click Animal Listening"),
                        await voicePlayer.play(
                          BytesSource(
                            animalProvider.getAnimals[index].voice,
                          ),
                        ),
                      };
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.memory(
                  animalProvider.getAnimals[index].image,
                ),
              ),
              // Image.network(animalProvider.getAnimalGif[index])),
            ),
          );
        },
      ),
    );
  }
}
