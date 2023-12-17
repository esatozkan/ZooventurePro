import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:onepref/onepref.dart';

class InAppPurchaseProvider with ChangeNotifier {
  final firebaseFirestore = FirebaseFirestore.instance.collection("users");
  //  GEMS
  late int gems;
  // REMOVE AD
  bool removeAdIsSubscribed = OnePref.getRemoveAds() ?? false;
  bool removeAdSubExisting = false;
  bool isRestore = false;
  late PurchaseDetails removeAdOldPurchaseDetails;
  //  BUY ANIMAL
  late bool buy24Animal=false;
  late bool buy36Animal=false;
  bool isAll24AnimalInformationDownload = false;
  bool isAll36AnimalInformationDownload = false;
  //  PREMIUM
  bool isPremiumSubscribed = OnePref.getPremium() ?? false;
  bool premiumSubExisting = false;
  bool premiumIsRestore = false;
  late PurchaseDetails premiumOldPurchaseDetails;

  late List<ProductDetails> products = <ProductDetails>[];
  final List<ProductId> _storeProductIds = <ProductId>[
    ProductId(id: "500_diamond", isConsumable: true, reward: 500),
    ProductId(id: "1500_diamond", isConsumable: true, reward: 1500),
    ProductId(id: "3500_diamond", isConsumable: true, reward: 3500),
    ProductId(id: "6000_diamond", isConsumable: true, reward: 6000),
    ProductId(id: "18000_diamond", isConsumable: true, reward: 18000),
    ProductId(id: "36000_diamond", isConsumable: true, reward: 36000),
    ProductId(id: "remove_ad_weekly", isConsumable: false),
    ProductId(id: "remove_ad_monthly", isConsumable: false),
    ProductId(id: "remove_ad_yearly", isConsumable: false),
    ProductId(id: "buy_24_animals", isConsumable: true),
    ProductId(id: "buy_36_animals", isConsumable: true),
    ProductId(id: "premium_weekly", isConsumable: false),
    ProductId(id: "premium_monthly", isConsumable: false),
    ProductId(id: "premium_yearly", isConsumable: false),
  ];

  IApEngine iApEngine = IApEngine();

  int get getGems => gems;
  bool get getRemoveAdIsSubscribed => removeAdIsSubscribed;
  bool get getRemoveAdSubExisting => removeAdSubExisting;
  bool get getIsRestore => isRestore;
  PurchaseDetails get getRemoveAdOldPurchaseDetails =>
      removeAdOldPurchaseDetails;
  bool get getIsAll24AnimalInformationDownload =>
      isAll24AnimalInformationDownload;
  bool get getIsAll36AnimalInformationDownload =>
      isAll36AnimalInformationDownload;
  bool get getBuy24Animal => buy24Animal;
  bool get getBuy36Animal => buy36Animal;
  bool get getIsPremiumSubscribed => isPremiumSubscribed;
  bool get getPremiumSubExisting => premiumSubExisting;
  PurchaseDetails get getPremiumOldPurchaseDetails => premiumOldPurchaseDetails;

  List<ProductDetails> get getProductsList => products;
  List<ProductId> get getStoreProductIds => _storeProductIds;

  IApEngine get getIApEngine => iApEngine;

  Future<void> getProducts() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(_storeProductIds).then((response) {
          products.clear();
          List<String> productOrder = [
            "500_diamond",
            "1500_diamond",
            "3500_diamond",
            "6000_diamond",
            "18000_diamond",
            "36000_diamond",
            "premium_weekly",
            "premium_monthly",
            "premium_yearly",
            "remove_ad_weekly",
            "remove_ad_monthly",
            "remove_ad_yearly",
            "buy_24_animals",
            "buy_36_animals",
          ];
          for (int i = 0; i < response.productDetails.length; i++) {
            int index = response.productDetails
                .indexWhere((element) => element.id == productOrder[i]);
            products.add(response.productDetails[index]);
          }
        });
      }
    });
    notifyListeners();
  }

  Future<void> listenPurchases(List<PurchaseDetails> list, context) async {
    List<String> gemsIds = [
      "500_diamond",
      "1500_diamond",
      "3500_diamond",
      "6000_diamond",
      "18000_diamond",
      "36000_diamond",
    ];
    List<String> buyAnimalsIds = [
      "buy_24_animals",
      "buy_36_animals",
    ];
    List<String> removeAdIds = [
      "remove_ad_weekly",
      "remove_ad_monthly",
      "remove_ad_yearly",
    ];
    for (PurchaseDetails purchase in list) {
      if (purchase.status == PurchaseStatus.restored ||
          purchase.status == PurchaseStatus.purchased) {
        if (gemsIds.contains(purchase.productID) ||
            buyAnimalsIds.contains(purchase.productID)) {
          if (Platform.isAndroid &&
              iApEngine
                  .getProductIdsOnly(_storeProductIds)
                  .contains(purchase.productID)) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                iApEngine.inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchase);
          }

          if (purchase.pendingCompletePurchase) {
            await iApEngine.inAppPurchase.completePurchase(purchase);
          }

          if (gemsIds.contains(purchase.productID)) {
            giveUserGems(purchase);
          }

          if (buyAnimalsIds.contains(purchase.productID)) {
            giveAnimalsToUser(purchase, context);
          }
        } else {
          Map purchaseData =
              json.decode(purchase.verificationData.localVerificationData);

          if (removeAdIds.contains(purchase.productID)) {
            if (list.isNotEmpty) {
              if (purchaseData["acknowledged"]) {
                removeAdIsSubscribed = true;
                OnePref.setRemoveAds(removeAdIsSubscribed);
              } else {
                //  first time purchase

                if (Platform.isAndroid) {
                  final InAppPurchaseAndroidPlatformAddition androidAddition =
                      iApEngine.inAppPurchase.getPlatformAddition<
                          InAppPurchaseAndroidPlatformAddition>();

                  await androidAddition.consumePurchase(purchase).then((value) {
                    updateIsRemoveAdSubscribe(true);
                  });
                }

                //   complete the purchase
                if (purchase.pendingCompletePurchase) {
                  await iApEngine.inAppPurchase
                      .completePurchase(purchase)
                      .then((value) {
                    updateIsRemoveAdSubscribe(true);
                  });
                }
              }
            } else {
              updateIsRemoveAdSubscribe(false);
            }
          } else {
            if (list.isNotEmpty) {
              if (purchaseData["acknowledged"]) {
                //restore purchase
                isPremiumSubscribed = true;
                OnePref.setPremium(isPremiumSubscribed);
              } else {
                //first time purchase
                if (Platform.isAndroid) {
                  final InAppPurchaseAndroidPlatformAddition
                      androidPlatformAddition = iApEngine.inAppPurchase
                          .getPlatformAddition<
                              InAppPurchaseAndroidPlatformAddition>();
                  await androidPlatformAddition
                      .consumePurchase(purchase)
                      .then((value) {
                    updateIsPremiumSubscribe(true);
                  });
                }
                if (purchase.pendingCompletePurchase) {
                  await iApEngine.inAppPurchase
                      .completePurchase(purchase)
                      .then((value) {
                    updateIsPremiumSubscribe(true);
                  });
                }
              }
            } else {
              updateIsPremiumSubscribe(false);
            }
          }
        }
      }
    }
  }

  void giveUserGems(PurchaseDetails purchaseDetails) async {
    for (var product in _storeProductIds) {
      if (product.id == purchaseDetails.productID) {
        gems += product.reward!;
        OnePref.setInt("gems", gems);
        firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
          "${product.reward!} gems sold": FieldValue.increment(1),
          "gems": gems,
        });
      }
    }
    notifyListeners();
  }

  void giveAnimalsToUser(PurchaseDetails purchaseDetails, context) {
    if (purchaseDetails.productID == "buy_24_animals") {
      setIs24Animal(true);
      OnePref.setBool("buy24Animals", true);
      firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "buy 24 animals": true,
      });
    }
    if (purchaseDetails.productID == "buy_36_animals") {
      setIs36Animal(true);
      OnePref.setBool("buy36Animals", true);
      firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "buy 36 animals": true,
      });
    }
  }

  void is24AnimalsDownloadFunction(bool val) {
    isAll24AnimalInformationDownload = val;

    notifyListeners();
  }

  void is36AnimalsDownloadFunction(bool val) {
    isAll36AnimalInformationDownload = val;
    notifyListeners();
  }

  void setIs24Animal(bool val) {
    buy24Animal = val;
    OnePref.setBool("buy24Animals", val);
    notifyListeners();
  }

  void setIs36Animal(bool val) {
    buy36Animal = val;
    OnePref.setBool("buy36Animals", val);
    notifyListeners();
  }

  void updateIsRemoveAdSubscribe(bool value) {
    removeAdIsSubscribed = value;
    OnePref.setRemoveAds(removeAdIsSubscribed);
    firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "Remove Ad Subscription": removeAdIsSubscribed,
    });
    notifyListeners();
  }

  void updateIsPremiumSubscribe(bool val) {
    isPremiumSubscribed = val;
    OnePref.setPremium(isPremiumSubscribed);
    firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "Premium Subscription": isPremiumSubscribed,
    });
    notifyListeners();
  }

  void setGemsValue(int value) async {
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

  void setPremiumSubExisting(bool value) {
    premiumSubExisting = value;
    notifyListeners();
  }

  void setPremiumOldPurchaseDetails(PurchaseDetails value) {
    premiumOldPurchaseDetails = value;
    notifyListeners();
  }

  void restoreSubscription() {
    iApEngine.inAppPurchase.restorePurchases();
  }

  void setIsRestore(bool val) {
    isRestore = val;
    notifyListeners();
  }

  void setPremiumIsRestore(bool value) {
    premiumIsRestore = value;
    notifyListeners();
  }
}
