import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/services/animal_service.dart';
import '/ui/views/widgets/internet_connection_widget.dart';
import '../../../../data/services/application_data_service.dart';
import '../../../providers/animal_provider.dart';
import '../../../providers/page_changed_provider.dart';
import '../../screens/main_screen.dart';

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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (size.width < 1100) ? 4 : 6,
        crossAxisSpacing: 10,
        childAspectRatio: .7,
      ),
      itemCount: animalProvider.getIsAllInformationDownload == true
          ? animalProvider.getAnimals.length
          : animalVirtualImages.length,
      itemBuilder: (BuildContext context, index) {
        return Consumer<AnimalProvider>(
          builder: (context, animalProvider, _) => IconButton(
            onPressed: () async {
              if (animalProvider.getIsAllInformationDownload) {
                pageChangedProvider.getPageChanged == 0
                    ? {
                        applicationData("Click Animal Name"),
                        {
                          await voicePlayer
                              .play(
                                BytesSource(
                                  animalProvider.getAnimals[index].name,
                                ),
                              )
                              .then((value) =>
                                  googleAdsProvider.showInterstitialAd()),
                        }
                      }
                    : {
                        applicationData("Click Animal Listening"),
                        await voicePlayer
                            .play(
                              BytesSource(
                                animalProvider.getAnimals[index].voice,
                              ),
                            )
                            .then((value) =>
                                googleAdsProvider.showInterstitialAd()),
                      };
              } else {
                showInformationSnackbar(context, "text");
              }
            },
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(
                animalProvider.getIsAllInformationDownload == true
                    ? animalProvider.getAnimals[index].image
                    : animalVirtualImages[index],
              ),
            ),
            // Image.network(animalProvider.getAnimalGif[index])),
          ),
        );
      },
    );
  }
}
