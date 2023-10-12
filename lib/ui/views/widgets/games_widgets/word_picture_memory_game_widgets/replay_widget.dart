import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zooventure/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/spin_animation.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_screen.dart';

const messages = ["Awesome!", "Fantastic!", "Nice!", "Great!"];

class ReplayWidget extends StatelessWidget {
  const ReplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random().nextInt(messages.length);
    String message = messages[random];

    return SpinAnimationWidget(
      child: AlertDialog(
        title: Text(
          message,
          textAlign: TextAlign.center,
        ),
        content: const Text(""),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          WordPictureMemoryGameScreen(),
                    ),
                    (route) => false);
              },
              child: Text("Replay"))
        ],
      ),
    );
  }
}
