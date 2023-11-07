import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import '/ui/views/screens/main_screen.dart';
import '../../../screens/games/memory_games_screen.dart';
import 'spin_animation.dart';

class ReplayWidget extends StatelessWidget {
  const ReplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    return SpinAnimationWidget(
      child: AlertDialog(
        backgroundColor: Colors.deepPurple,
        content: const Text(
          '🥳',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 80),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(animalProvider.getUiTexts[4]),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const MemoryGamesScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(animalProvider.getUiTexts[5]),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
                Navigator.of(context).pop();
                pageController.jumpToPage(2);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     PageRouteBuilder(pageBuilder: (_, __, ___) => MyApp()),
                //     (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(animalProvider.getUiTexts[6]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
