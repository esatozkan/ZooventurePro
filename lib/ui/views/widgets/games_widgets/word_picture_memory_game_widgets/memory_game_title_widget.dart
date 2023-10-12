import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'word_picture_memory_game_provider.dart';
import 'word_picture_memory_game_screen.dart';

class MemoryGameTitleWidget extends StatelessWidget {
  const MemoryGameTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/game_control/back_icon.png",
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            color: Colors.deepPurple,
          ),
        ),
        Consumer<WordPictureMemoryGameProvider>(
          builder: (_, wordPictureMemoryGameProvider, __) => Text(
            wordPictureMemoryGameProvider.getMove.toString(),
            style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 40,
                fontFamily: "bubblegumSans"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        const WordPictureMemoryGameScreen(),
                  ),
                  (route) => false);
            },
            icon: Image.asset(
              "assets/bottom_navbar_icon/gameScreenIcon.png",
              height: 60,
              width: 60,
              color: Colors.deepPurple,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
