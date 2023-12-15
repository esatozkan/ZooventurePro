import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../providers/page_changed_provider.dart';
import 'memory_games_provider.dart';

class MemoryGamesTitleWidget extends StatelessWidget {
  const MemoryGamesTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);

            pageChangedProvider.pageChangedFunction(2);
          },
          child: Image.asset(
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
        const SizedBox(
          height: 60,
          width: 60,
        ),
      ],
    );
  }
}
