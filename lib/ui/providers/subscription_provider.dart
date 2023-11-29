import 'dart:convert';
import 'dart:io';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:onepref/onepref.dart';

class SubscriptionProvider with ChangeNotifier {
  bool subExisting = false;
  bool isRestore = false;
  late PurchaseDetails oldPurchaseDetails;

  //bool
  bool isSubscribeRemoveAd = OnePref.getRemoveAds() ?? false;

//List Products
  late final List<ProductDetails> products = <ProductDetails>[];

  List<ProductDetails> get getProductsList => products;
  List<ProductId> get getStoreProductIds => productIds;
  bool get getIsSubscribeRemoveAd => isSubscribeRemoveAd;
  bool get getSubExisting => subExisting;
  bool get getIsRestore => isRestore;
  PurchaseDetails get getOldPurchaseDetails => oldPurchaseDetails;

//List of ProductIds

  final List<ProductId> productIds = <ProductId>[
    ProductId(id: "remove_ad_weekly", isConsumable: false),
    ProductId(id: "remove_ad_monthly", isConsumable: false),
    ProductId(id: "remove_ad_yearly", isConsumable: false),
    // ProductId(id: "remove_ad", isConsumable: false)
  ];

//IApEngine
  IApEngine iApEngine = IApEngine();

  IApEngine get getIApEngine => iApEngine;

  Future<void> getProducts() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(productIds).then((res) {
          products.clear();
          products.addAll(res.productDetails);
        });
      }
    });
    isSubscribeRemoveAd = OnePref.getRemoveAds() ?? false;
    notifyListeners();
  }

  Future<void> listenPurchases(List<PurchaseDetails> list) async {
    if (list.isNotEmpty) {
      for (PurchaseDetails purchaseDetails in list) {
        if (purchaseDetails.status == PurchaseStatus.restored ||
            purchaseDetails.status == PurchaseStatus.purchased) {
          print(purchaseDetails.verificationData.localVerificationData);
          Map purchaseData = json
              .decode(purchaseDetails.verificationData.localVerificationData);
          if (purchaseData["acknowledged"]) {
            print("restore purchase");
            isSubscribeRemoveAd = true;
            OnePref.setRemoveAds(isSubscribeRemoveAd);
          } else {
            print("first time purchase");
            if (Platform.isAndroid) {
              final InAppPurchaseAndroidPlatformAddition
                  androidPlatformAddition = iApEngine.inAppPurchase
                      .getPlatformAddition<
                          InAppPurchaseAndroidPlatformAddition>();

              await androidPlatformAddition
                  .consumePurchase(purchaseDetails)
                  .then((value) {
                updateIsSubRemoveAd(true);
              });
            }
            if (purchaseDetails.pendingCompletePurchase) {
              await iApEngine.inAppPurchase
                  .completePurchase(purchaseDetails)
                  .then((value) {
                updateIsSubRemoveAd(true);
              });
            }
          }
        }
      }
    } else {
      updateIsSubRemoveAd(false);
    }
  }

  void updateIsSubRemoveAd(bool value) {
    isSubscribeRemoveAd = value;
    OnePref.setRemoveAds(isSubscribeRemoveAd);
    notifyListeners();
  }

  void updateSubExisting(bool val) {
    subExisting = val;
    notifyListeners();
  }

  void setRestore(bool val) {
    isRestore = val;
    notifyListeners();
  }

  void setOldPurchaseDetails(PurchaseDetails purchaseDetails) {
    oldPurchaseDetails = purchaseDetails;
    notifyListeners();
  }

  void restoreSubscription() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
