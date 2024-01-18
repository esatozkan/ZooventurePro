import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/views/screens/main_screen.dart';
import '/ui/providers/animal_provider.dart';
import '../../../../providers/page_changed_provider.dart';
import '/data/constants/constants.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_provider.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.sessionCompleted,
  }) : super(key: key);

  final bool sessionCompleted;

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);

    String title = "Well Done!";
    String buttonText = "New Word";

    if (sessionCompleted) {
      title = "All Words Completed";
      buttonText = animalProvider.getUiTexts["replay"];
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Colors.amber,
      title: Text(
        title,
        style: spellingBeeGameThemeData.textTheme.displayLarge,
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              onPressed: () {
                if (sessionCompleted) {
                  Provider.of<SpellingBeeGameProvider>(context, listen: false)
                      .resetGame();
                  Navigator.of(context).pop();
                  pageChangedProvider.pageChangedFunction(8);
                } else {
                  Provider.of<SpellingBeeGameProvider>(context, listen: false)
                      .requestWord(request: true);
                  Navigator.of(context).pop();
                }
                googleAdsProvider.showInterstitialAd(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonText,
                  style:
                      spellingBeeGameThemeData.textTheme.displayLarge?.copyWith(
                    fontSize: 30,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: sessionCompleted,
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]).then((value) {
                  Provider.of<SpellingBeeGameProvider>(context, listen: false)
                      .resetGame();
                  Navigator.of(context).pop();
                  Provider.of<PageChangedProvider>(context, listen: false)
                      .pageChangedFunction(2);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  animalProvider.getUiTexts["quit"],
                  style:
                      spellingBeeGameThemeData.textTheme.displayLarge?.copyWith(
                    fontSize: 30,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
