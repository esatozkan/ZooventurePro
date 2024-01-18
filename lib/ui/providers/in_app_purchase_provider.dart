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

  bool isAll24AnimalInformationDownload = false;
  bool isAll36AnimalInformationDownload = false;

  IApEngine iApEngine = IApEngine();

  List<ProductDetails> get getProductsDetails => _products;
  List<ProductId> get getProductIds => _productIds;

  bool get getIsRemoveAdSubscribed => isRemoveAdSubscribed;
  bool get getIsBuy24AnimalSubscribed => isBuy24AnimalSubscribed;
  bool get getIsBuy36AnimalSubscribed => isBuy36AnimalSubscribed;
  bool get getIsPremiumSubscribed => isPremiumSubscribed;

  bool get getIsAll24AnimalInformationDownload =>
      isAll24AnimalInformationDownload;
  bool get getIsAll36AnimalInformationDownload =>
      isAll36AnimalInformationDownload;

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

  void is24AnimalsDownloadFunction(bool val) {
    isAll24AnimalInformationDownload = val;

    notifyListeners();
  }

  void is36AnimalsDownloadFunction(bool val) {
    isAll36AnimalInformationDownload = val;
    notifyListeners();
  }

  void restoreSubscription() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}






// class InAppPurchaseProvider with ChangeNotifier {
//   // REMOVE AD
//   bool removeAdIsSubscribed = OnePref.getRemoveAds() ?? false;
//   bool removeAdSubExisting = false;
//   bool isRestore = false;
//   late PurchaseDetails removeAdOldPurchaseDetails;
//   //  BUY ANIMAL
//   late bool buy24Animal = false;
//   late bool buy36Animal = false;
//   bool isAll24AnimalInformationDownload = false;
//   bool isAll36AnimalInformationDownload = false;
//   //  PREMIUM
//   bool isPremiumSubscribed = OnePref.getPremium() ?? false;
//   bool premiumSubExisting = false;
//   bool premiumIsRestore = false;
//   late PurchaseDetails premiumOldPurchaseDetails;

//   late List<ProductDetails> products = <ProductDetails>[];
//   final List<ProductId> _storeProductIds = <ProductId>[
//     ProductId(id: "500_diamond", isConsumable: true, reward: 500),
//     ProductId(id: "1500_diamond", isConsumable: true, reward: 1500),
//     ProductId(id: "3500_diamond", isConsumable: true, reward: 3500),
//     ProductId(id: "6000_diamond", isConsumable: true, reward: 6000),
//     ProductId(id: "18000_diamond", isConsumable: true, reward: 18000),
//     ProductId(id: "36000_diamond", isConsumable: true, reward: 36000),
//     ProductId(id: "remove_ad_weekly", isConsumable: false),
//     ProductId(id: "remove_ad_monthly", isConsumable: false),
//     ProductId(id: "remove_ad_yearly", isConsumable: false),
//     ProductId(
//         id: "buy_24_animals", isConsumable: false, isOneTimePurchase: true),
//     ProductId(
//         id: "buy_36_animals", isConsumable: false, isOneTimePurchase: true),
//     ProductId(id: "premium_weekly", isConsumable: false),
//     ProductId(id: "premium_monthly", isConsumable: false),
//     ProductId(id: "premium_yearly", isConsumable: false),
//   ];

//   IApEngine iApEngine = IApEngine();

//   bool get getRemoveAdIsSubscribed => removeAdIsSubscribed;
//   bool get getRemoveAdSubExisting => removeAdSubExisting;
//   bool get getIsRestore => isRestore;
//   PurchaseDetails get getRemoveAdOldPurchaseDetails =>
//       removeAdOldPurchaseDetails;
//   bool get getIsAll24AnimalInformationDownload =>
//       isAll24AnimalInformationDownload;
//   bool get getIsAll36AnimalInformationDownload =>
//       isAll36AnimalInformationDownload;
//   bool get getBuy24Animal => buy24Animal;
//   bool get getBuy36Animal => buy36Animal;
//   bool get getIsPremiumSubscribed => isPremiumSubscribed;
//   bool get getPremiumSubExisting => premiumSubExisting;
//   PurchaseDetails get getPremiumOldPurchaseDetails => premiumOldPurchaseDetails;

//   List<ProductDetails> get getProductsList => products;
//   List<ProductId> get getStoreProductIds => _storeProductIds;

//   IApEngine get getIApEngine => iApEngine;

//   Future<void> getProducts() async {
//     await iApEngine.getIsAvailable().then((value) async {
//       if (value) {
//         await iApEngine.queryProducts(_storeProductIds).then((response) {
//           products.clear();
//           List<String> productOrder = [
//             "500_diamond",
//             "1500_diamond",
//             "3500_diamond",
//             "6000_diamond",
//             "18000_diamond",
//             "36000_diamond",
//             "premium_weekly",
//             "premium_monthly",
//             "premium_yearly",
//             "remove_ad_weekly",
//             "remove_ad_monthly",
//             "remove_ad_yearly",
//             "buy_24_animals",
//             "buy_36_animals",
//           ];
//           for (int i = 0; i < response.productDetails.length; i++) {
//             int index = response.productDetails
//                 .indexWhere((element) => element.id == productOrder[i]);
//             products.add(response.productDetails[index]);
//           }
//         });
//       }
//     });
//     notifyListeners();
//   }

//   Future<void> listenPurchases(List<PurchaseDetails> list, context) async {
//     List<String> gemsIds = [
//       "500_diamond",
//       "1500_diamond",
//       "3500_diamond",
//       "6000_diamond",
//       "18000_diamond",
//       "36000_diamond",
//     ];
//     List<String> buyAnimalsIds = [
//       "buy_24_animals",
//       "buy_36_animals",
//     ];
//     List<String> removeAdIds = [
//       "remove_ad_weekly",
//       "remove_ad_monthly",
//       "remove_ad_yearly",
//     ];
//     for (PurchaseDetails purchase in list) {
//       if (purchase.status == PurchaseStatus.restored ||
//           purchase.status == PurchaseStatus.purchased) {
//         if (gemsIds.contains(purchase.productID) ||
//             buyAnimalsIds.contains(purchase.productID)) {
//           if (Platform.isAndroid &&
//               iApEngine
//                   .getProductIdsOnly(_storeProductIds)
//                   .contains(purchase.productID)) {
//             final InAppPurchaseAndroidPlatformAddition androidAddition =
//                 iApEngine.inAppPurchase.getPlatformAddition<
//                     InAppPurchaseAndroidPlatformAddition>();
//             await androidAddition.consumePurchase(purchase);
//           }

//           if (purchase.pendingCompletePurchase) {
//             await iApEngine.inAppPurchase.completePurchase(purchase);
//           }

//           if (buyAnimalsIds.contains(purchase.productID)) {
//             giveAnimalsToUser(purchase, context);
//           }
//         } else {
//           Map purchaseData =
//               json.decode(purchase.verificationData.localVerificationData);

//           if (removeAdIds.contains(purchase.productID)) {
//             if (list.isNotEmpty) {
//               if (purchaseData["acknowledged"]) {
//                 removeAdIsSubscribed = true;
//                 OnePref.setRemoveAds(removeAdIsSubscribed);
//               } else {
//                 //  first time purchase

//                 if (Platform.isAndroid) {
//                   final InAppPurchaseAndroidPlatformAddition androidAddition =
//                       iApEngine.inAppPurchase.getPlatformAddition<
//                           InAppPurchaseAndroidPlatformAddition>();

//                   await androidAddition.consumePurchase(purchase).then((value) {
//                     updateIsRemoveAdSubscribe(true);
//                   });
//                 }

//                 //   complete the purchase
//                 if (purchase.pendingCompletePurchase) {
//                   await iApEngine.inAppPurchase
//                       .completePurchase(purchase)
//                       .then((value) {
//                     updateIsRemoveAdSubscribe(true);
//                   });
//                 }
//               }
//             } else {
//               updateIsRemoveAdSubscribe(false);
//             }
//           } else {
//             if (list.isNotEmpty) {
//               if (purchaseData["acknowledged"]) {
//                 //restore purchase
//                 isPremiumSubscribed = true;
//                 OnePref.setPremium(isPremiumSubscribed);
//               } else {
//                 //first time purchase
//                 if (Platform.isAndroid) {
//                   final InAppPurchaseAndroidPlatformAddition
//                       androidPlatformAddition = iApEngine.inAppPurchase
//                           .getPlatformAddition<
//                               InAppPurchaseAndroidPlatformAddition>();
//                   await androidPlatformAddition
//                       .consumePurchase(purchase)
//                       .then((value) {
//                     updateIsPremiumSubscribe(true);
//                   });
//                 }
//                 if (purchase.pendingCompletePurchase) {
//                   await iApEngine.inAppPurchase
//                       .completePurchase(purchase)
//                       .then((value) {
//                     updateIsPremiumSubscribe(true);
//                   });
//                 }
//               }
//             } else {
//               updateIsPremiumSubscribe(false);
//             }
//           }
//         }
//       }
//     }
//   }

//   void giveAnimalsToUser(PurchaseDetails purchaseDetails, context) {
//     if (purchaseDetails.productID == "buy_24_animals") {
//       setIs24Animal(true);
//       OnePref.setBool("buy24Animals", true);
//     }
//     if (purchaseDetails.productID == "buy_36_animals") {
//       setIs36Animal(true);
//       OnePref.setBool("buy36Animals", true);
//     }
//   }

//   void is24AnimalsDownloadFunction(bool val) {
//     isAll24AnimalInformationDownload = val;

//     notifyListeners();
//   }

//   void is36AnimalsDownloadFunction(bool val) {
//     isAll36AnimalInformationDownload = val;
//     notifyListeners();
//   }

//   void setIs24Animal(bool val) {
//     buy24Animal = val;
//     OnePref.setBool("buy24Animals", val);
//     notifyListeners();
//   }

//   void setIs36Animal(bool val) {
//     buy36Animal = val;
//     OnePref.setBool("buy36Animals", val);
//     notifyListeners();
//   }

//   void updateIsRemoveAdSubscribe(bool value) {
//     removeAdIsSubscribed = value;
//     OnePref.setRemoveAds(removeAdIsSubscribed);
//     notifyListeners();
//   }

//   void updateIsPremiumSubscribe(bool val) {
//     isPremiumSubscribed = val;
//     OnePref.setPremium(isPremiumSubscribed);
//     notifyListeners();
//   }

//   void setRemoveAdSubExisting(bool value) {
//     removeAdSubExisting = value;
//     notifyListeners();
//   }

//   void setOldPurchaseDetails(PurchaseDetails value) {
//     removeAdOldPurchaseDetails = value;
//     notifyListeners();
//   }

//   void setPremiumSubExisting(bool value) {
//     premiumSubExisting = value;
//     notifyListeners();
//   }

//   void setPremiumOldPurchaseDetails(PurchaseDetails value) {
//     premiumOldPurchaseDetails = value;
//     notifyListeners();
//   }

//   void restoreSubscription() {
//     iApEngine.inAppPurchase.restorePurchases();
//   }

//   void setIsRestore(bool val) {
//     isRestore = val;
//     notifyListeners();
//   }

//   void setPremiumIsRestore(bool value) {
//     premiumIsRestore = value;
//     notifyListeners();
//   }
// }
