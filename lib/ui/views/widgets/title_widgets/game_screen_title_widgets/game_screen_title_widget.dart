import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/data/services/user_service.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '/ui/providers/lives_provider.dart';
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
    FirebaseAuth auth = FirebaseAuth.instance;
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            if (animalProvider.getIsAllInformationDownload) {
              if (
                  // ignore: use_build_context_synchronously
                  Provider.of<InAppPurchaseProvider>(context, listen: false)
                      .getProductsList
                      .isNotEmpty) {
                if (auth.currentUser != null) {
                  //   ignore: use_build_context_synchronously
                  buyGemWidget(context);
                } else {
                  // ignore: use_build_context_synchronously
                  createUserInformationData(context);
                }
              }
            } else {
              // ignore: use_build_context_synchronously
              showInformationSnackbar(context, "text");
            }
          },
          child: Consumer<InAppPurchaseProvider>(
            builder: (context, inAppPurchaseProvider, _) =>
                GameScreenTitleWidgetIcon(
              icon: Icon(
                Icons.diamond,
                size: 30,
                color: itemColor,
              ),
              text: inAppPurchaseProvider.getGems < 1000
                  ? inAppPurchaseProvider.getGems.toString()
                  : (inAppPurchaseProvider.getGems > 999 &&
                          inAppPurchaseProvider.getGems < 1000000)
                      ? "${(inAppPurchaseProvider.getGems / 1000.0).toStringAsFixed(1)} K"
                      : "${(inAppPurchaseProvider.getGems / 1000000.0).toStringAsFixed(1)} B",
              color: Colors.black12,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Consumer<LivesProvider>(
          builder: (context, livesProvider, _) => GameScreenTitleWidgetIcon(
            icon: const Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            ),
            text: livesProvider.getLive == 5
                ? "full"
                : "${livesProvider.getRemainingMinutes} : ${livesProvider.getRemainingSeconds}",
            isChance: true,
            color: Colors.black12,
          ),
        )
      ],
    );
  }
}
