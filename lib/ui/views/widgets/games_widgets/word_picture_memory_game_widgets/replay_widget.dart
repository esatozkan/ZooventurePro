import 'dart:math';
import 'package:flutter/material.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/spin_animation.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_screen.dart';

const messages = ["Awesome!", "Fantastic!", "Nice!", "Great!"];

class ReplayWidget extends StatelessWidget {
  const ReplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Random().nextInt(messages.length);
    String message = messages[r];

    return SpinAnimationWidget(
      child: AlertDialog(
        title: Text(
          message,
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '🥳',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60),
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
                        pageBuilder: (_, __, ___) =>
                            const WordPictureMemoryGameScreen()),
                    (route) => false);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Replay!'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
