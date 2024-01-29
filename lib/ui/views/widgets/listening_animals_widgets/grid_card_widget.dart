import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/services/animal_service.dart';
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

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (size.width < 1100) ? 3 : 6,
        childAspectRatio: 1,
      ),
      itemCount: freeAnimals.length,
      itemBuilder: (BuildContext context, index) {
        return IconButton(
          onPressed: () async {
            pageChangedProvider.getPageChanged == 0
                ? {
                    {
                      await voicePlayer
                          .play(AssetSource(freeAnimals[index].animalType))
                          .then((value) =>
                              googleAdsProvider.showInterstitialAd(context)),
                    }
                  }
                : {
                    await voicePlayer
                        .play(AssetSource(freeAnimals[index].animalVoice))
                        .then((value) =>
                            googleAdsProvider.showInterstitialAd(context)),
                  };
          },
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(freeAnimals[index].animalVirtualImage),
          ),
          // Image.network(animalProvider.getAnimalGif[index])),
        );
      },
    );
  }
}
