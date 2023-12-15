import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '/ui/views/widgets/title_widgets/in_app_purchase_widgets/buy_gem_icon.widget.dart';
import '../../../../../data/constants/constants.dart';
import '../game_screen_title_widgets/game_screen_title_widget_icon.dart';

buyGemWidget(context) {
  List<String> images = [
    "assets/gem_images/500.png",
    "assets/gem_images/1500.png",
    "assets/gem_images/3500.png",
    "assets/gem_images/6000.png",
    "assets/gem_images/18000.png",
    "assets/gem_images/36000.png",
  ];

  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        height: (MediaQuery.of(context).size.height * 7) / 8,
        width: (MediaQuery.of(context).size.width * 7) / 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
                image: AssetImage(
                    "assets/purchases_icon/in_app_purchases_background_image.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
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
                          color: Colors.white38,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        Provider.of<AnimalProvider>(context, listen: false)
                            .getUiTexts["gem store"],
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "displayFont",
                          color: itemColor,
                        ),
                      ),
                    ),
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? const Text("")
                        : Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              top: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/close_icon.png",
                                color: itemColor,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                margin:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? const EdgeInsets.only(top: 20)
                        : const EdgeInsets.all(0),
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? (gemIconHeight * 3) + 40
                        : (gemIconHeight * 2) + 20,
                width: (gemIconWidth * 3) + 60,
                child: GridView.builder(
                  itemCount: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 10,
                    childAspectRatio: gemIconWidth / gemIconHeight,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        inAppPurchaseProvider.getIApEngine.handlePurchase(
                            inAppPurchaseProvider.getProductsList[index],
                            inAppPurchaseProvider.getStoreProductIds);
                      },
                      child: BuyGemIconWidget(
                        imageAsset: images[index],
                        text: inAppPurchaseProvider
                            .getProductsList[index].description,
                        gemCount: inAppPurchaseProvider
                            .getProductsList[index].id
                            .substring(
                          0,
                          inAppPurchaseProvider.getProductsList[index].id
                              .indexOf("_"),
                        ),
                        price:
                            inAppPurchaseProvider.getProductsList[index].price,
                      ),
                    );
                  },
                ),
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff7dd507),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/close_icon.png",
                          color: itemColor,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const Text("")
            ],
          ),
        ),
      ),
    ),
  );
}
