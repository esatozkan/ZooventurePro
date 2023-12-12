import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:onepref/onepref.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';
import '../../data/models/animal_model.dart';

class InAppPurchaseProvider with ChangeNotifier {
  final firebaseFirestore = FirebaseFirestore.instance.collection("users");

  //GEMS
  //late int gems;
  late int gems = 0;
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

  //BUY ANIMAL
  bool buy24Animal = false;
  bool buy36Animal = false;
  // bool buy24Animal = OnePref.getBool("buy24Animals") ?? false;
  // bool buy36Animal = OnePref.getBool("buy36animals") ?? false;
  bool isAll24AnimalInformationDownload = false;
  bool isAll36AnimalInformationDownload = false;
  late final List<ProductDetails> buyAnimalProducts = <ProductDetails>[];
  final List<ProductId> _buyAnimalProductIds = <ProductId>[
    ProductId(id: "buy_24_animals", isConsumable: true),
    ProductId(id: "buy_36_animals", isConsumable: true),
  ];

  //PREMİUM
  bool isPremiumSubscribed = OnePref.getPremium() ?? false;
  late final List<ProductDetails> premiumProducts = <ProductDetails>[];
  final List<ProductId> _premiumProductIds = <ProductId>[
    ProductId(id: "premium_monthly", isConsumable: false),
    ProductId(id: "premium_weekly", isConsumable: false),
    ProductId(id: "premium_yearly", isConsumable: false),
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

  bool get getBuy24Animal => buy24Animal;
  bool get getBuy36Animal => buy36Animal;
  bool get getIsAll24AnimalInformationDownload =>
      isAll24AnimalInformationDownload;
  bool get getIsAll36AnimalInformationDownload =>
      isAll36AnimalInformationDownload;
  List<ProductDetails> get getBuyAnimalProducts => buyAnimalProducts;
  List<ProductId> get getBuyAnimalProductIds => _buyAnimalProductIds;

  bool get getIsPremiumSubscribed => isPremiumSubscribed;
  List<ProductDetails> get getPremiumProducts => premiumProducts;
  List<ProductId> get getPremiumProductIds => _premiumProductIds;

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
        await iApEngine.queryProducts(_buyAnimalProductIds).then((response) {
          buyAnimalProducts.addAll(response.productDetails);
        });
        await iApEngine.queryProducts(_premiumProductIds).then((response) {
          premiumProducts.clear();
          premiumProducts.addAll(response.productDetails);
        });
      }
    });
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

  Future<void> listenPremiumSubscribe(List<PurchaseDetails> list) async {
    if (list.isNotEmpty) {
      for (PurchaseDetails purchaseDetails in list) {
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
              final InAppPurchaseAndroidPlatformAddition
                  androidPlatformAddition = iApEngine.inAppPurchase
                      .getPlatformAddition<
                          InAppPurchaseAndroidPlatformAddition>();
              await androidPlatformAddition
                  .consumePurchase(purchaseDetails)
                  .then((value) {
                updateIsPremiumSubscribe(true);
              });
            }
            if (purchaseDetails.pendingCompletePurchase) {
              await iApEngine.inAppPurchase
                  .completePurchase(purchaseDetails)
                  .then((value) {
                updateIsPremiumSubscribe(true);
              });
            }
          }
        }
      }
    } else {
      updateIsPremiumSubscribe(false);
    }
  }

  Future<void> listenBuyAnimal(List<PurchaseDetails> list, context) async {
    for (PurchaseDetails purchase in list) {
      if (purchase.status == PurchaseStatus.restored ||
          purchase.status == PurchaseStatus.purchased) {
        if (Platform.isAndroid &&
            iApEngine
                .getProductIdsOnly(_buyAnimalProductIds)
                .contains(purchase.productID)) {
          final InAppPurchaseAndroidPlatformAddition androidPlatformAddition =
              iApEngine.inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();

          await androidPlatformAddition.consumePurchase(purchase);
        }
        if (purchase.pendingCompletePurchase) {
          await iApEngine.inAppPurchase.completePurchase(purchase);
        }
        giveAnimalsToUser(purchase, context);
      }
    }
  }

  void giveAnimalsToUser(PurchaseDetails purchaseDetails, context) {
    if (purchaseDetails.productID == "buy_24_animals") {
      Box animal24Box = Hive.box<Animal>("buy24animals");
      is24AnimalsDownloadFunction(true);
      OnePref.setBool("buy24Animals", true);
      firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "buy 24 animals": true,
      });
      for (int i = 0; i < animal24Box.length; i++) {
        final animal = animal24Box.get(i);
        Animal generateAnimal = Animal(
          name: animal.name,
          voice: animal.voice,
          image: animal.image,
          realImage: animal.realImage,
          spelling: animal.spelling,
        );
        Provider.of<AnimalProvider>(context, listen: false)
            .addAnimal(generateAnimal);
      }
    }
    if (purchaseDetails.productID == "buy_36_animals") {
      Box animal36Box = Hive.box<Animal>("buy36animals");
      is36AnimalsDownloadFunction(true);
      OnePref.setBool("buy36Animals", true);
      firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "buy 36 animals": true,
      });
      for (int i = 0; i < animal36Box.length; i++) {
        final animal = animal36Box.get(i);
        Animal generateAnimal = Animal(
          name: animal.name,
          voice: animal.voice,
          image: animal.image,
          realImage: animal.realImage,
          spelling: animal.spelling,
        );
        Provider.of<AnimalProvider>(context, listen: false)
            .addAnimal(generateAnimal);
      }
    }
  }

  void updateIsRemoveAdSubscribe(bool value) {
    removeAdIsSubscribed = value;
    OnePref.setRemoveAds(removeAdIsSubscribed);
    notifyListeners();
  }

  void updateIsPremiumSubscribe(bool val) {
    isPremiumSubscribed = val;
    OnePref.setPremium(isPremiumSubscribed);
    notifyListeners();
  }

  void giveUserGems(PurchaseDetails purchaseDetails) async {
    for (var product in _gemStoreProductIds) {
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

  void setIsRestore(bool val) {
    isRestore = val;
    notifyListeners();
  }

  void restoreSubscription() {
    iApEngine.inAppPurchase.restorePurchases();
  }

  void is24AnimalsDownloadFunction(bool val) {
    isAll24AnimalInformationDownload = val;
    OnePref.setBool("buy24Animals", val);
    notifyListeners();
  }

  void is36AnimalsDownloadFunction(bool val) {
    isAll36AnimalInformationDownload = val;
    OnePref.setBool("buy36Animals", val);
    notifyListeners();
  }
}
