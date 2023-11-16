import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/page_changed_provider.dart';
import 'fly_in_animation_widget.dart';
import 'spelling_bee_game_provider.dart';

class SpellingBeeGameTitleWidget extends StatefulWidget {
  const SpellingBeeGameTitleWidget({super.key});

  @override
  State<SpellingBeeGameTitleWidget> createState() =>
      _SpellingBeeGameTitleWidgetState();
}

class _SpellingBeeGameTitleWidgetState
    extends State<SpellingBeeGameTitleWidget> {
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
          GestureDetector(
            onTap: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]).then((value) {
                Provider.of<SpellingBeeGameProvider>(context, listen: false)
                    .resetGame();
                Provider.of<PageChangedProvider>(context, listen: false)
                    .pageChangedFunction(2);
              });
            },
            child: Image.asset(
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
                "assets/games/spelling_bee_games/bee.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
            width: 60,
          ),
        ],
      ),
    );
  }
}
