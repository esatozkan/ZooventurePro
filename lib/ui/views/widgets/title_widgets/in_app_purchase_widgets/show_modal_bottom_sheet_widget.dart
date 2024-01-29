import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/data/services/text_services.dart';
import '../../../../providers/in_app_purchase_provider.dart';
import '../../internet_connection_widget.dart';

Future<dynamic> showModalBottomSheetWidget(context, int productIndex) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of(context, listen: false);

  return showModalBottomSheet(
    backgroundColor: const Color(0xfff6e2fe),
    context: context,
    builder: (_) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: ((MediaQuery.of(context).size.height * 2) / 3),
            child: ListView.builder(
              itemCount: inAppPurchaseProvider.getProductsDetails.length ~/ 4,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if (productIndex == 0) {
                    Navigator.of(context).pop();

                    if (!inAppPurchaseProvider.getIsBuy24AnimalSubscribed) {
                      inAppPurchaseProvider.getIApEngine.handlePurchase(
                          inAppPurchaseProvider
                              .getProductsDetails[index + productIndex],
                          inAppPurchaseProvider.getProductIds);
                    } else {
                      showInformationSnackbar(
                          context, texts["subscribe available"].toString());
                    }
                  }

                  if (productIndex == 3) {
                    Navigator.of(context).pop();

                    if (!inAppPurchaseProvider.getIsBuy36AnimalSubscribed) {
                      inAppPurchaseProvider.getIApEngine.handlePurchase(
                          inAppPurchaseProvider
                              .getProductsDetails[index + productIndex],
                          inAppPurchaseProvider.getProductIds);
                    } else {
                      showInformationSnackbar(
                          context, texts["subscribe available"].toString());
                    }
                  }

                  if (productIndex == 6) {
                    Navigator.of(context).pop();

                    if (!inAppPurchaseProvider.getIsRemoveAdSubscribed) {
                      inAppPurchaseProvider.getIApEngine.handlePurchase(
                          inAppPurchaseProvider
                              .getProductsDetails[index + productIndex],
                          inAppPurchaseProvider.getProductIds);
                    } else {
                      showInformationSnackbar(
                          context, texts["subscribe available"].toString());
                    }
                  }
                  if (productIndex == 9) {
                    Navigator.of(context).pop();

                    if (!inAppPurchaseProvider.getIsPremiumSubscribed) {
                      inAppPurchaseProvider.getIApEngine.handlePurchase(
                          inAppPurchaseProvider
                              .getProductsDetails[index + productIndex],
                          inAppPurchaseProvider.getProductIds);
                    } else {
                      showInformationSnackbar(
                          context, texts["subscribe available"].toString());
                    }
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ListTile(
                    title: Text(inAppPurchaseProvider
                        .getProductsDetails[index + productIndex].description),
                    subtitle: productIndex == 0
                        ? const Text("Buy 24 animals")
                        : productIndex == 3
                            ? const Text("Buy 36 animals")
                            : productIndex == 6
                                ? const Text("Remove ads")
                                : const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Remove Ads"),
                                      Text("Language Options Available"),
                                      Text("Buy 24 and 36 animals"),
                                    ],
                                  ),
                    trailing: Text(
                      inAppPurchaseProvider
                          .getProductsDetails[index + productIndex].price,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 800
                              ? 20
                              : 35),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
