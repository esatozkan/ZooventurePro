import 'package:flutter/material.dart';
import 'package:zooventure/data/constants/constants.dart';
import 'package:zooventure/ui/views/widgets/title_widgets/game_screen_title_widgets/title_widget_icon.dart';

class GameScreenTitleWidget extends StatelessWidget {
  const GameScreenTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleWidgetIcon(
          icon: Icon(
            Icons.diamond,
            size: 35,
            color: itemColor,
          ),
          text: "300",
        ),
        SizedBox(
          width: 10,
        ),
        TitleWidgetIcon(
          icon: Icon(
            Icons.favorite,
            size: 35,
            color: Colors.red,
          ),
          text: "full",
          isChance: true,
        )
      ],
    );
  }
}
