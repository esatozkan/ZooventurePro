//ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import '/ui/views/widgets/internet_connection_widget.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import 'subscribe_widget.dart';
import '../../../../../data/constants/constants.dart';

class PurchaseIconWidget extends StatefulWidget {
  final String icon;
  final String text;
  final String whichFunction;
  final bool isLoading;
  const PurchaseIconWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.whichFunction,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<PurchaseIconWidget> createState() => _PurchaseIconWidget();
}

class _PurchaseIconWidget extends State<PurchaseIconWidget> {
  @override
  Widget build(BuildContext context) {
    InAppPurchaseProvider inAppPurchaseProvider =
        Provider.of(context, listen: false);
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          if (widget.whichFunction == "removeAds") {
            if (!inAppPurchaseProvider.getIsPremiumSubscribed) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]).then((value) {
                subscribeWidget(
                  context,
                  animalProvider.getUiTexts["remove ads"],
                  "assets/in_app_purchase_background/no_live_vertical.png",
                  "removeAd",
                );
              });
            } else {
              Navigator.of(context).pop();
              showInformationSnackbar(
                  context, animalProvider.getUiTexts["subscribe available"]);
            }
          } else if (widget.whichFunction == "buy_24_animals") {
            if (!inAppPurchaseProvider.getIsPremiumSubscribed) {
              if (inAppPurchaseProvider.getIsAll24AnimalInformationDownload) {
                inAppPurchaseProvider.getIApEngine.handlePurchase(
                    inAppPurchaseProvider.getProductsList[
                        inAppPurchaseProvider.getProductsList.indexWhere(
                            (element) => element.id == "buy_24_animals")],
                    inAppPurchaseProvider.getStoreProductIds);
              } else {
                Navigator.of(context).pop();
                showInformationSnackbar(
                    context, animalProvider.getUiTexts["loading the animal"]);
              }
            } else {
              Navigator.of(context).pop();
              showInformationSnackbar(
                  context, animalProvider.getUiTexts["subscribe available"]);
            }
          } else if (widget.whichFunction == "buy_36_animals") {
            if (!inAppPurchaseProvider.getIsPremiumSubscribed) {
              if (inAppPurchaseProvider.getIsAll36AnimalInformationDownload) {
                inAppPurchaseProvider.getIApEngine.handlePurchase(
                    inAppPurchaseProvider.getProductsList[
                        inAppPurchaseProvider.getProductsList.indexWhere(
                            (element) => element.id == "buy_36_animals")],
                    inAppPurchaseProvider.getStoreProductIds);
              } else {
                Navigator.of(context).pop();
                showInformationSnackbar(
                    context, animalProvider.getUiTexts["loading the animal"]);
              }
            } else {
              Navigator.of(context).pop();
              showInformationSnackbar(
                  context, animalProvider.getUiTexts["subscribe available"]);
            }
          } else if (widget.whichFunction == "premium") {
            if (inAppPurchaseProvider.getIsAll24AnimalInformationDownload &&
                inAppPurchaseProvider.getIsAll36AnimalInformationDownload) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]).then((value) {
                subscribeWidget(
                  context,
                  animalProvider.getUiTexts["buy premium"],
                  "assets/in_app_purchase_background/no_live_vertical.png",
                  "premium",
                );
              });
            } else {
              Navigator.of(context).pop();
              showInformationSnackbar(
                  context, animalProvider.getUiTexts["loading the animal"]);
            }
          }
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.isLoading == true
                    ? "assets/get_firebase_loading.gif"
                    : widget.icon,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                color: widget.isLoading == true ? itemColor : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontFamily: "displayFont",
                  fontSize: 20,
                  color: itemColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
