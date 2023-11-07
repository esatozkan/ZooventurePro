import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'in_app_purchase_icon_widget.dart';
import '../../../../providers/animal_provider.dart';
import '../../../../../data/constants/constants.dart';

inAppPurchaseWidget(context) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        height: (MediaQuery.of(context).size.height * 7) / 8,
        width: (MediaQuery.of(context).size.width * 7) / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: giftWidgetItemColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text(
                      animalProvider.getUiTexts[15],
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "jokerman",
                        color: itemColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: itemColor,
                          size: 32,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PurchaseIconWidget(
                    icon: "assets/purchases_icon/buy_24_animals.gif",
                    text: animalProvider.getUiTexts[16],
                    whichFunction: "",
                  ),
                  PurchaseIconWidget(
                    icon: "assets/purchases_icon/buy_36_animals.gif",
                    text: animalProvider.getUiTexts[17],
                    whichFunction: "",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PurchaseIconWidget(
                    icon: "assets/purchases_icon/premium_icon.gif",
                    text: animalProvider.getUiTexts[0],
                    whichFunction: "",
                  ),
                  PurchaseIconWidget(
                    icon: "assets/purchases_icon/play_with_ads.gif",
                    text: animalProvider.getUiTexts[6],
                    whichFunction: "",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
