import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/ui/views/screens/main_screen.dart';
import '../../../screens/games/memory_games_screen.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/spin_animation.dart';

class ReplayWidget extends StatelessWidget {
  const ReplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Buy'),
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
                        pageBuilder: (_, __, ___) => const MemoryGamesScreen()),
                    (route) => false);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Replay!'),
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
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Exit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
