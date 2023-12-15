import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import 'package:zooventure/ui/views/widgets/internet_connection_widget.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../../../../../data/constants/constants.dart';

subscribeWidget(
    context, String titleText, String imagePath, String whichSubscribe) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (_) => Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]).then(
              (value) => Navigator.of(context).pop(),
            );
          },
          child: Image.asset(
            "assets/bottom_navbar_icon/left_swipe.png",
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          titleText,
          style: TextStyle(
            fontSize: 32,
            fontFamily: "displayFont",
            color: itemColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
        child: whichSubscribe == "removeAd"
            ? Column(
                children: [
                  const Spacer(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () async {
                            if (!inAppPurchaseProvider
                                .getRemoveAdIsSubscribed) {
                              inAppPurchaseProvider.getIApEngine.handlePurchase(
                                  inAppPurchaseProvider
                                      .getProductsList[index + 9],
                                  inAppPurchaseProvider.getStoreProductIds);
                            } else {
                              showInformationSnackbar(
                                  context,
                                  animalProvider
                                      .getUiTexts["subscribe available"]);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              color: itemColor,
                            ),
                            child: ListTile(
                              title: Text(inAppPurchaseProvider
                                  .getProductsList[index + 9].description),
                              trailing: Text(
                                inAppPurchaseProvider
                                    .getProductsList[index + 9].price,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      Visibility(
                        visible: !inAppPurchaseProvider.getRemoveAdIsSubscribed,
                        child: ListTile(
                          title: Text(
                            animalProvider.getUiTexts["remove ads"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Image.asset(
                            "assets/games/question_games/question_game/correct_answer.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !inAppPurchaseProvider.getBuy24Animal,
                        child: ListTile(
                          title: Text(
                            animalProvider.getUiTexts["buy 24 animals"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Image.asset(
                            "assets/games/question_games/question_game/correct_answer.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !inAppPurchaseProvider.getBuy36Animal,
                        child: ListTile(
                          title: Text(
                            animalProvider.getUiTexts["buy 36 animals"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Image.asset(
                            "assets/games/question_games/question_game/correct_answer.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            if (!inAppPurchaseProvider.getIsPremiumSubscribed) {
                              inAppPurchaseProvider.getIApEngine.handlePurchase(
                                  inAppPurchaseProvider
                                      .getProductsList[index + 6],
                                  inAppPurchaseProvider.getStoreProductIds);
                            } else {
                              showInformationSnackbar(
                                  context, "abonelik bulunmaktadır");
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              color: itemColor,
                            ),
                            child: ListTile(
                              title: Text(inAppPurchaseProvider
                                  .getProductsList[index + 6].description),
                              trailing: Text(
                                inAppPurchaseProvider
                                    .getProductsList[index + 6].price,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    ),
  );
}
