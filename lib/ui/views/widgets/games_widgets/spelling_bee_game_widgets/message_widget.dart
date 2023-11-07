import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import '../../../screens/games/spelling_bee_game_screen.dart';
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

    String title = "Well Done!";
    String buttonText = "New Word";

    if (sessionCompleted) {
      title = "All Words Completed";
      buttonText = animalProvider.getUiTexts[3];
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
              child: Visibility(
                visible: sessionCompleted,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        animalProvider.getUiTexts[4],
                        style: spellingBeeGameThemeData.textTheme.displayLarge
                            ?.copyWith(
                          fontSize: 30,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: sessionCompleted,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        animalProvider.getUiTexts[5],
                        style: spellingBeeGameThemeData.textTheme.displayLarge
                            ?.copyWith(
                          fontSize: 30,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SpellingBeeGameScreen(),
                      ),
                    );
                  } else {
                    Provider.of<SpellingBeeGameProvider>(context, listen: false)
                        .requestWord(request: true);
                    Navigator.of(context).pop();
                  }
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
          
      ],
    );
  }
}
