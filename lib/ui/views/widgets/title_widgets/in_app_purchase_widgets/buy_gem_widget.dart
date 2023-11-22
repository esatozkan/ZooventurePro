import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '/ui/views/widgets/title_widgets/in_app_purchase_widgets/buy_gem_icon.widget.dart';
import '../../../../../data/constants/constants.dart';
import '../game_screen_title_widgets/game_screen_title_widget_icon.dart';

buyGemWidget(context) {
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
                      child: GestureDetector(
                        child: GameScreenTitleWidgetIcon(
                          icon: Icon(
                            Icons.diamond,
                            size: 30,
                            color: itemColor,
                          ),
                          text: inAppPurchaseProvider.getGems.toString(),
                          color: Colors.white38,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        "Gem Store",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "displayFont",
                          color: itemColor,
                        ),
                      ),
                    ),
                    Padding(
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: (gemIconHeight * 2) + 20,
                width: (gemIconWidth * 3) + 60,
                child: GridView.builder(
                  itemCount: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
                        imageAsset: "assets/gem_images/36000.png",
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
            ],
          ),
        ),
      ),
    ),
  );
}
