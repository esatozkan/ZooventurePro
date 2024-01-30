import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:onepref/onepref.dart';

class InAppPurchaseProvider with ChangeNotifier {
  late final List<ProductDetails> _products = <ProductDetails>[];
  final List<ProductId> _productIds = <ProductId>[
    ProductId(id: "buy_24_animal_weekly", isConsumable: false),
    ProductId(id: "buy_24_animal_monthly", isConsumable: false),
    ProductId(id: "buy_24_animal_yearly", isConsumable: false),
    ProductId(id: "buy_36_animal_weekly", isConsumable: false),
    ProductId(id: "buy_36_animal_monthly", isConsumable: false),
    ProductId(id: "buy_36_animal_yearly", isConsumable: false),
    ProductId(id: "remove_ad_weekly", isConsumable: false),
    ProductId(id: "remove_ad_monthly", isConsumable: false),
    ProductId(id: "remove_ad_yearly", isConsumable: false),
    ProductId(id: "premium_weekly", isConsumable: false),
    ProductId(id: "premium_monthly", isConsumable: false),
    ProductId(id: "premium_yearly", isConsumable: false),
  ];

  bool isRemoveAdSubscribed = OnePref.getRemoveAds() ?? false;
  bool isBuy24AnimalSubscribed =
      OnePref.getBool("isBuy24AnimalSubscribed") ?? false;
  bool isBuy36AnimalSubscribed =
      OnePref.getBool("isBuy36AnimalSubscribed") ?? false;
  bool isPremiumSubscribed = OnePref.getPremium() ?? false;


  IApEngine iApEngine = IApEngine();

  List<ProductDetails> get getProductsDetails => _products;
  List<ProductId> get getProductIds => _productIds;

  bool get getIsRemoveAdSubscribed => isRemoveAdSubscribed;
  bool get getIsBuy24AnimalSubscribed => isBuy24AnimalSubscribed;
  bool get getIsBuy36AnimalSubscribed => isBuy36AnimalSubscribed;
  bool get getIsPremiumSubscribed => isPremiumSubscribed;

  IApEngine get getIApEngine => iApEngine;

  void getProducts() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(_productIds).then((res) {
          _products.clear();

          List<String> productOrder = [
            "buy_24_animal_weekly",
            "buy_24_animal_monthly",
            "buy_24_animal_yearly",
            "buy_36_animal_weekly",
            "buy_36_animal_monthly",
            "buy_36_animal_yearly",
            "remove_ad_weekly",
            "remove_ad_monthly",
            "remove_ad_yearly",
            "premium_weekly",
            "premium_monthly",
            "premium_yearly",
          ];
          for (int i = 0; i < res.productDetails.length; i++) {
            int index = res.productDetails
                .indexWhere((element) => element.id == productOrder[i]);
            _products.add(res.productDetails[index]);
          }
        });
      }
    });
  }

  Future<void> listenPurchases(List<PurchaseDetails> list) async {
    List<String> removeAdProducts = [
      "remove_ad_weekly",
      "remove_ad_monthly",
      "remove_ad_yearly",
    ];

    List<String> buy24AnimalProducts = [
      "buy_24_animal_weekly",
      "buy_24_animal_monthly",
      "buy_24_animal_yearly",
    ];

    List<String> buy36AnimalProducts = [
      "buy_36_animal_weekly",
      "buy_36_animal_monthly",
      "buy_36_animal_yearly",
    ];

    for (PurchaseDetails purchaseDetails in list) {
      if (removeAdProducts.contains(purchaseDetails.productID)) {
        if (list.isNotEmpty) {
          if (purchaseDetails.status == PurchaseStatus.restored ||
              purchaseDetails.status == PurchaseStatus.purchased) {
            Map purchaseData = json
                .decode(purchaseDetails.verificationData.localVerificationData);

            if (purchaseData["acknowledged"]) {
              //restore purchase
              isRemoveAdSubscribed = true;
              OnePref.setRemoveAds(isRemoveAdSubscribed);
            } else {
              //first time purchase
              if (Platform.isAndroid) {
                final InAppPurchaseAndroidPlatformAddition androidAddition =
                    iApEngine.inAppPurchase.getPlatformAddition<
                        InAppPurchaseAndroidPlatformAddition>();
                await androidAddition
                    .consumePurchase(purchaseDetails)
                    .then((value) {
                  updateIsRemoveAdSubscription(true);
                });
              }

              //complete purchase
              if (purchaseDetails.pendingCompletePurchase) {
                await iApEngine.inAppPurchase
                    .completePurchase(purchaseDetails)
                    .then((value) {
                  updateIsRemoveAdSubscription(true);
                });
              }
            }
          }
        } else {
          updateIsRemoveAdSubscription(false);
        }
      } else if (buy24AnimalProducts.contains(purchaseDetails.productID)) {
        if (list.isNotEmpty) {
          if (purchaseDetails.status == PurchaseStatus.restored ||
              purchaseDetails.status == PurchaseStatus.purchased) {
            Map purchaseData = json
                .decode(purchaseDetails.verificationData.localVerificationData);

            if (purchaseData["acknowledged"]) {
              //restore purchase
              isBuy24AnimalSubscribed = true;
              OnePref.setBool("isBuy24AnimalSubscribed", isBuy24AnimalSubscribed);
            } else {
              //first time purchase
              if (Platform.isAndroid) {
                final InAppPurchaseAndroidPlatformAddition androidAddition =
                    iApEngine.inAppPurchase.getPlatformAddition<
                        InAppPurchaseAndroidPlatformAddition>();
                await androidAddition
                    .consumePurchase(purchaseDetails)
                    .then((value) {
                  updateBuy24AnimalSubscription(true);
                });
              }

              //complete purchase
              if (purchaseDetails.pendingCompletePurchase) {
                await iApEngine.inAppPurchase
                    .completePurchase(purchaseDetails)
                    .then((value) {
                  updateBuy24AnimalSubscription(true);
                });
              }
            }
          }
        } else {
          updateBuy24AnimalSubscription(false);
        }
      } else if (buy36AnimalProducts.contains(purchaseDetails.productID)) {
        if (list.isNotEmpty) {
          if (purchaseDetails.status == PurchaseStatus.restored ||
              purchaseDetails.status == PurchaseStatus.purchased) {
            Map purchaseData = json
                .decode(purchaseDetails.verificationData.localVerificationData);

            if (purchaseData["acknowledged"]) {
              //restore purchase
              isBuy36AnimalSubscribed = true;
              OnePref.setBool("isBuy36AnimalSubscribed", isBuy36AnimalSubscribed);
            } else {
              //first time purchase
              if (Platform.isAndroid) {
                final InAppPurchaseAndroidPlatformAddition androidAddition =
                    iApEngine.inAppPurchase.getPlatformAddition<
                        InAppPurchaseAndroidPlatformAddition>();
                await androidAddition
                    .consumePurchase(purchaseDetails)
                    .then((value) {
                  updateBuy36AnimalSubscription(true);
                });
              }

              //complete purchase
              if (purchaseDetails.pendingCompletePurchase) {
                await iApEngine.inAppPurchase
                    .completePurchase(purchaseDetails)
                    .then((value) {
                  updateBuy36AnimalSubscription(true);
                });
              }
            }
          }
        } else {
          updateBuy36AnimalSubscription(false);
        }
      } else {
        if (list.isNotEmpty) {
          if (purchaseDetails.status == PurchaseStatus.restored ||
              purchaseDetails.status == PurchaseStatus.purchased) {
            Map purchaseData = json
                .decode(purchaseDetails.verificationData.localVerificationData);

            if (purchaseData["acknowledged"]) {
              //restore purchase
              isPremiumSubscribed = true;
              OnePref.setPremium(isPremiumSubscribed);
            } else {
              //first time purchase
              if (Platform.isAndroid) {
                final InAppPurchaseAndroidPlatformAddition androidAddition =
                    iApEngine.inAppPurchase.getPlatformAddition<
                        InAppPurchaseAndroidPlatformAddition>();
                await androidAddition
                    .consumePurchase(purchaseDetails)
                    .then((value) {
                  updateIsPremiumSubscription(true);
                });
              }

              //complete purchase
              if (purchaseDetails.pendingCompletePurchase) {
                await iApEngine.inAppPurchase
                    .completePurchase(purchaseDetails)
                    .then((value) {
                  updateIsPremiumSubscription(true);
                });
              }
            }
          }
        } else {
          updateIsPremiumSubscription(false);
        }
      }
    }
  }

  void updateIsRemoveAdSubscription(bool value) {
    isRemoveAdSubscribed = value;
    OnePref.setRemoveAds(isRemoveAdSubscribed);
    notifyListeners();
  }

  void updateBuy24AnimalSubscription(bool value) {
    isBuy24AnimalSubscribed = value;
    OnePref.setBool("isBuy24AnimalSubscribed", isBuy24AnimalSubscribed);
    notifyListeners();
  }

  void updateBuy36AnimalSubscription(bool value) {
    isBuy36AnimalSubscribed = value;
    OnePref.setBool("isBuy36AnimalSubscribed", isBuy36AnimalSubscribed);
    notifyListeners();
  }

  void updateIsPremiumSubscription(bool value) {
    isPremiumSubscribed = value;
    OnePref.setPremium(isPremiumSubscribed);
    notifyListeners();
  }

  void restoreSubscription() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
