import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'memory_games_provider.dart';
import '../../../screens/games/memory_games_screen.dart';

class MemoryGamesTitleWidget extends StatelessWidget {
  const MemoryGamesTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          },
          icon: Image.asset(
            "assets/game_control/back_icon.png",
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            color: Colors.deepPurple,
          ),
        ),
        Consumer<MemoryGamesProvider>(
          builder: (_, memoryGameProvider, __) => Text(
            memoryGameProvider.getMove.toString(),
            style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 40,
              fontFamily: "bubblegumSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
               Navigator.pushAndRemoveUntil(
                   context,
                   PageRouteBuilder(
                     pageBuilder: (_, __, ___) => const MemoryGamesScreen(),
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
