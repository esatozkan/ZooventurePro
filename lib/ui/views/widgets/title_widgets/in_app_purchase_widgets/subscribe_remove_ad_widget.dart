import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/in_app_purchase_provider.dart';
import '../../../../../data/constants/constants.dart';

subscribeRemoveAdWidget(context) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);
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
                "Remove Ads",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "displayFont",
                  color: itemColor,
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/in_app_purchase_background/no_live_vertical.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image.asset(
                      "assets/purchases_icon/play_with_ads.gif",
                      width: (MediaQuery.of(context).size.width / 4),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          inAppPurchaseProvider.getRemoveAdProducts.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () async {
                            inAppPurchaseProvider.setIsRestore(false);

                            await inAppPurchaseProvider
                                .getIApEngine.inAppPurchase
                                .restorePurchases()
                                .whenComplete(() async {
                              await Future.delayed(const Duration(seconds: 1))
                                  .then((value) async {
                                if (inAppPurchaseProvider
                                        .getRemoveAdSubExisting &&
                                    inAppPurchaseProvider
                                            .getRemoveAdOldPurchaseDetails
                                            .productID !=
                                        inAppPurchaseProvider
                                            .getRemoveAdProducts[index].id) {
                                  // await inAppPurchaseProvider.getIApEngine
                                  //     .upgradeOrDowngradeSubscription(
                                  //         inAppPurchaseProvider
                                  //             .getRemoveAdOldPurchaseDetails,
                                  //         inAppPurchaseProvider
                                  //             .getRemoveAdProducts[index])
                                  //     .then((value) {
                                  //   inAppPurchaseProvider
                                  //       .setRemoveAdSubExisting(false);
                                  // });

                                  PurchaseParam purchaseParam = GooglePlayPurchaseParam(
                                      productDetails: inAppPurchaseProvider
                                          .getRemoveAdProducts[index],
                                      changeSubscriptionParam: ChangeSubscriptionParam(
                                          oldPurchaseDetails: inAppPurchaseProvider
                                                  .getRemoveAdOldPurchaseDetails
                                              as GooglePlayPurchaseDetails,
                                          prorationMode: ProrationMode
                                              .immediateWithTimeProration));
                                  InAppPurchase.instance.buyNonConsumable(
                                      purchaseParam: purchaseParam);
                                } else {
                                  inAppPurchaseProvider.getIApEngine
                                      .handlePurchase(
                                          inAppPurchaseProvider
                                              .getRemoveAdProducts[index],
                                          inAppPurchaseProvider
                                              .getRemoveAdProductIds);
                                }
                              });
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
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
                                  .getRemoveAdProducts[index].description),
                              trailing: Text(
                                inAppPurchaseProvider
                                    .getRemoveAdProducts[index].price,
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
              ),
            ),
          ));
}
