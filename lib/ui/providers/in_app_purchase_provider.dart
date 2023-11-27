import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:onepref/onepref.dart';

class InAppPurchaseProvider with ChangeNotifier {
  int gems = 0;
  // List Products
  late List<ProductDetails> products = <ProductDetails>[];
  //IapEngine
  IApEngine iApEngine = IApEngine();
  //List Of Product Ids
  List<ProductId> storeProductIds = <ProductId>[
    ProductId(id: "500_diamond", isConsumable: true, reward: 500),
    ProductId(id: "1500_diamond", isConsumable: true, reward: 1500),
    ProductId(id: "3500_diamond", isConsumable: true, reward: 3500),
    ProductId(id: "6000_diamond", isConsumable: true, reward: 6000),
    ProductId(id: "18000_diamond", isConsumable: true, reward: 18000),
    ProductId(id: "36000_diamond", isConsumable: true, reward: 36000),
  ];

  List<ProductDetails> get getProductsList => products;
  IApEngine get getIApEngine => iApEngine;
  List<ProductId> get getStoreProductIds => storeProductIds;
  int get getGems => gems;

  Future<void> getProducts() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(storeProductIds).then((response) {
          products.addAll(response.productDetails);
          products.sort(
            (a, b) => int.parse(a.id.substring(
              0,
              a.id.indexOf("_"),
            )).compareTo(int.parse(
              b.id.substring(
                0,
                b.id.indexOf("_"),
              ),
            )),
          );
        });
      }
    });
    gems = OnePref.getInt("gems") ?? 0;
    notifyListeners();
  }

  Future<void> listenPurchases(List<PurchaseDetails> list) async {
    for (PurchaseDetails purchase in list) {
      if (purchase.status == PurchaseStatus.restored ||
          purchase.status == PurchaseStatus.purchased) {
        if (Platform.isAndroid &&
            iApEngine
                .getProductIdsOnly(storeProductIds)
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

  void giveUserGems(PurchaseDetails purchaseDetails) {
    gems = OnePref.getInt("gems") ?? 0;

    for (var product in storeProductIds) {
      if (product.id == purchaseDetails.productID) {
        gems += product.reward!;
        OnePref.setInt("gems", gems);
      }
    }
    notifyListeners();
  }

  void setGems(int value) {
    gems = value;
    notifyListeners();
  }
}
