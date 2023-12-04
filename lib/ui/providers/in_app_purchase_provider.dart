import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:onepref/onepref.dart';

class InAppPurchaseProvider with ChangeNotifier {
  //GEMS
  late int gems;
  late List<ProductDetails> gemProducts = <ProductDetails>[];
  final List<ProductId> _gemStoreProductIds = <ProductId>[
    ProductId(id: "500_diamond", isConsumable: true, reward: 500),
    ProductId(id: "1500_diamond", isConsumable: true, reward: 1500),
    ProductId(id: "3500_diamond", isConsumable: true, reward: 3500),
    ProductId(id: "6000_diamond", isConsumable: true, reward: 6000),
    ProductId(id: "18000_diamond", isConsumable: true, reward: 18000),
    ProductId(id: "36000_diamond", isConsumable: true, reward: 36000),
  ];

//REMOVE AD
  bool removeAdIsSubscribed = OnePref.getRemoveAds() ?? false;
  bool removeAdSubExisting = false;
  bool isRestore = false;
  late PurchaseDetails removeAdOldPurchaseDetails;
  late final List<ProductDetails> removeAdProducts = <ProductDetails>[];
  final List<ProductId> _removeAdProductIds = <ProductId>[
    ProductId(id: "remove_ad_weekly", isConsumable: false),
    ProductId(id: "remove_ad_monthly", isConsumable: false),
    ProductId(id: "remove_ad_yearly", isConsumable: false),
  ];

  //BUY 24 ANİMALS
  bool isBuyRestoreAnimals = false;
  late final List<ProductDetails> buy24Products = <ProductDetails>[];
  final List<ProductId> _buy24ProductIds = <ProductId>[
    ProductId(
        id: "buy_24_animals", isConsumable: true, isOneTimePurchase: true),
    ProductId(
        id: "buy_36_animals", isConsumable: true, isOneTimePurchase: true),
  ];

  IApEngine iApEngine = IApEngine();

  List<ProductDetails> get getGemProductsList => gemProducts;
  List<ProductId> get getGemStoreProductIds => _gemStoreProductIds;
  int get getGems => gems;

  List<ProductDetails> get getRemoveAdProducts => removeAdProducts;
  List<ProductId> get getRemoveAdProductIds => _removeAdProductIds;
  PurchaseDetails get getRemoveAdOldPurchaseDetails =>
      removeAdOldPurchaseDetails;
  bool get getRemoveAdIsSubscribed => removeAdIsSubscribed;
  bool get getRemoveAdSubExisting => removeAdSubExisting;

  IApEngine get getIApEngine => iApEngine;

  Future<void> getProducts() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(_gemStoreProductIds).then((response) {
          gemProducts.addAll(response.productDetails);
          gemProducts.sort(
            (a, b) => int.parse(a.id.substring(
              0,
              a.id.indexOf("_"),
            )).compareTo(
              int.parse(
                b.id.substring(
                  0,
                  b.id.indexOf("_"),
                ),
              ),
            ),
          );
        });
        await iApEngine.queryProducts(_removeAdProductIds).then((response) {
          removeAdProducts.clear();
          removeAdProducts.addAll(response.productDetails);
        });
      }
    });
    gems = OnePref.getInt("gems") ?? 0;
    notifyListeners();
  }

  Future<void> listenGemPurchases(List<PurchaseDetails> list) async {
    for (PurchaseDetails purchase in list) {
      if (purchase.status == PurchaseStatus.restored ||
          purchase.status == PurchaseStatus.purchased) {
        if (Platform.isAndroid &&
            iApEngine
                .getProductIdsOnly(_gemStoreProductIds)
                .contains(purchase.productID)) {
          final InAppPurchaseAndroidPlatformAddition androidAddition = iApEngine
              .inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchase);
        }

        if (purchase.pendingCompletePurchase) {
          await iApEngine.inAppPurchase.completePurchase(purchase);
        }

        //deliver the product
        giveUserGems(purchase);
      }
    }
  }

  Future<void> listenRemoveAdSubscribe(List<PurchaseDetails> list) async {
    if (list.isNotEmpty) {
      for (PurchaseDetails purchaseDetails in list) {
        if (purchaseDetails.status == PurchaseStatus.restored ||
            purchaseDetails.status == PurchaseStatus.purchased) {
          Map purchaseData = json
              .decode(purchaseDetails.verificationData.localVerificationData);

          if (purchaseData["acknowledged"]) {
            removeAdIsSubscribed = true;
            OnePref.setRemoveAds(removeAdIsSubscribed);
          } else {
            //first time purchase

            if (Platform.isAndroid) {
              final InAppPurchaseAndroidPlatformAddition androidAddition =
                  iApEngine.inAppPurchase.getPlatformAddition<
                      InAppPurchaseAndroidPlatformAddition>();

              await androidAddition
                  .consumePurchase(purchaseDetails)
                  .then((value) {
                updateIsRemoveAdSubscribe(true);
              });
            }

            //complete the purchase
            if (purchaseDetails.pendingCompletePurchase) {
              await iApEngine.inAppPurchase
                  .completePurchase(purchaseDetails)
                  .then((value) {
                updateIsRemoveAdSubscribe(true);
              });
            }
          }
        }
      }
    } else {
      updateIsRemoveAdSubscribe(false);
    }
  }

  void updateIsRemoveAdSubscribe(bool value) {
    removeAdIsSubscribed = value;
    OnePref.setRemoveAds(removeAdIsSubscribed);
    notifyListeners();
  }

  void giveUserGems(PurchaseDetails purchaseDetails) {
    gems = OnePref.getInt("gems") ?? 0;

    for (var product in _gemStoreProductIds) {
      if (product.id == purchaseDetails.productID) {
        gems += product.reward!;
        OnePref.setInt("gems", gems);
      }
    }
    notifyListeners();
  }

  void setGemsValue(int value) {
    gems = value;
    OnePref.setInt("gems", gems);
    notifyListeners();
  }

  void setRemoveAdSubExisting(bool value) {
    removeAdSubExisting = value;
    notifyListeners();
  }

  void setOldPurchaseDetails(PurchaseDetails value) {
    removeAdOldPurchaseDetails = value;
    notifyListeners();
  }

  void setIsRestore(bool val) {
    isRestore = val;
    notifyListeners();
  }

  void restoreSubscription() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
