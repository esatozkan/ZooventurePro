import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/repository/generate_asset_animal.dart';
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
    AnimalProvider animalProvider = Provider.of<AnimalProvider>(context);

    final Size size = MediaQuery.of(context).size;

    print(animalProvider.getAnimals.length);
    print("*************");

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (size.width < 1100) ? 4 : 6,
        crossAxisSpacing: 10,
        childAspectRatio: .7,
      ),
      itemCount: animalProvider.getIsAllInformationDownload == true
          ? animalProvider.getAnimals.length
          : assetAnimals.length,
      itemBuilder: (BuildContext context, index) {
        return Consumer<AnimalProvider>(
          builder: (context, animalProvider, _) => IconButton(
            onPressed: () async {
              if (animalProvider.getIsAllInformationDownload) {
                pageChangedProvider.getPageChanged == 0
                    ? {
                        {
                          await voicePlayer
                              .play(
                                BytesSource(
                                  animalProvider.getAnimals[index].name,
                                ),
                              )
                              .then((value) => googleAdsProvider
                                  .showInterstitialAd(context)),
                        }
                      }
                    : {
                        await voicePlayer
                            .play(
                              BytesSource(
                                animalProvider.getAnimals[index].voice,
                              ),
                            )
                            .then((value) =>
                                googleAdsProvider.showInterstitialAd(context)),
                      };
              } else {
                pageChangedProvider.getPageChanged == 0
                    ? {
                        {
                          await voicePlayer
                              .play(AssetSource(assetAnimals[index].animalType))
                              .then((value) => googleAdsProvider
                                  .showInterstitialAd(context)),
                        }
                      }
                    : {
                        await voicePlayer
                            .play(AssetSource(assetAnimals[index].animalVoice))
                            .then((value) =>
                                googleAdsProvider.showInterstitialAd(context)),
                      };
              }
            },
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: animalProvider.getIsAllInformationDownload == true
                  ? Image.memory(animalProvider.getAnimals[index].image)
                  : Image.asset(assetAnimals[index].animalVirtualImage),
            ),
            // Image.network(animalProvider.getAnimalGif[index])),
          ),
        );
      },
    );
  }
}
