import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'fly_in_animation_widget.dart';
import 'spelling_bee_game_provider.dart';
import '../../../screens/games/spelling_bee_game_screen.dart';

class SpellingBeeGameTitleWidget extends StatelessWidget {
  const SpellingBeeGameTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    animatedCompleted() {
      Future.delayed(const Duration(milliseconds: 200), () {
        Provider.of<SpellingBeeGameProvider>(context, listen: false)
            .updateLetterDropped(dropped: false);
      });
    }

    return SizedBox(
      child: Row(
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
              color: Colors.amber,
            ),
          ),
          Selector<SpellingBeeGameProvider, bool>(
            selector: (_, spellingBeeGameProvider) =>
                spellingBeeGameProvider.letterDropped,
            builder: (_, dropped, __) => FlyInAnimationWidget(
              removeScale: true,
              animate: dropped,
              animationCompleted: animatedCompleted(),
              child: Image.asset(
                "assets/spelling_bee_games/bee.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Provider.of<SpellingBeeGameProvider>(context, listen: false)
                    .resetGame();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SpellingBeeGameScreen(),
                  ),
                );
              },
              icon: Image.asset(
                "assets/bottom_navbar_icon/gameScreenIcon.png",
                height: 60,
                width: 60,
                color: Colors.amber,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
