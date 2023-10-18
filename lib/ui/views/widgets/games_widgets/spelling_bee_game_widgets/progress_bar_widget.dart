import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_provider.dart';

class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({super.key});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double begin = 0;
  double end = 0;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    animation = Tween<double>(begin: begin, end: end).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    ));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SpellingBeeGameProvider, double>(
      selector: (_, spellingBeeGameProvider) =>
          spellingBeeGameProvider.percentCompleted,
      builder: (_, percent, __) {
        end = percent;

        if (!controller.isAnimating) {
          animation = Tween<double>(begin: begin, end: end).animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.elasticInOut,
            ),
          );
          controller.reset();
          controller.forward();
          begin = end;
          if (begin == 1) {
            begin = 0;
            end = 0;
          }
        }

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: LinearProgressIndicator(
                color: Colors.amber,
                backgroundColor: Colors.grey,
                value: animation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}
