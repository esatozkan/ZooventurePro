import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/in_app_purchase_provider.dart';
import '../../../../providers/animal_provider.dart';
import '../../internet_connection_widget.dart';
import '../in_app_purchase_widgets/buy_gem_widget.dart';
import '/data/constants/constants.dart';
import 'game_screen_title_widget_icon.dart';

class GameScreenTitleWidget extends StatelessWidget {
  const GameScreenTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            var connectivityResult = await Connectivity().checkConnectivity();
            if (animalProvider.getIsAllInformationDownload) {
              if (connectivityResult != ConnectivityResult.none) {
                // ignore: use_build_context_synchronously
                buyGemWidget(context);
              } else if (connectivityResult == ConnectivityResult.none) {
                // ignore: use_build_context_synchronously
                showInformationSnackbar(
                  context,
                  animalProvider.getUiTexts[14],
                );
              }
            } else {
              // ignore: use_build_context_synchronously
              showInformationSnackbar(context, "text");
            }
          },
          child: GameScreenTitleWidgetIcon(
            icon: Icon(
              Icons.diamond,
              size: 30,
              color: itemColor,
            ),
            text: Provider.of<InAppPurchaseProvider>(context, listen: false)
                .getGems
                .toString(),
            color: Colors.black12,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const GameScreenTitleWidgetIcon(
          icon: Icon(
            Icons.favorite,
            size: 30,
            color: Colors.red,
          ),
          text: "full",
          isChance: true,
          color: Colors.black12,
        )
      ],
    );
  }
}
