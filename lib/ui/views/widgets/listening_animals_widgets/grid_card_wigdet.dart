import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/services/application_data_service.dart';
import '../../../providers/animal_provider.dart';
import '../../../providers/page_changed_provider.dart';

class GridCardWigdet extends StatefulWidget {
  const GridCardWigdet({super.key});

  @override
  State<GridCardWigdet> createState() => _GridCardWigdetState();
}

class _GridCardWigdetState extends State<GridCardWigdet> {
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
        itemCount: animalProvider.getAnimalGif.length,
        itemBuilder: (BuildContext context, index) {
          return Consumer<AnimalProvider>(
            builder: (context, animalProvider, _) => IconButton(
              onPressed: () async {
                pageChangedProvider.getPageChanged == 0
                    ? {
                        applicationData("Click Animal Name"),
                        await voicePlayer.play(
                          UrlSource(
                            animalProvider.getAnimals[index].name,
                          ),
                        ),
                      }
                    : {
                        applicationData("Click Animal Listening"),
                        await voicePlayer.play(
                          UrlSource(
                            animalProvider.getAnimals[index].voice,
                          ),
                        ),
                      };
              },
              icon: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(animalProvider.getAnimalGif[index])),
            ),
          );
        },
      ),
    );
  }
}
