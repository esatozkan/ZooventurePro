import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '/ui/views/widgets/internet_connection_widget.dart';
import '/ui/views/widgets/title_widgets/in_app_purchase_widgets/buy_gem_widget.dart';
import '../../../../data/constants/constants.dart';
import '../../../providers/lives_provider.dart';

noLiveWidget(context) {
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? (MediaQuery.of(context).size.height * 7) / 10
            : (MediaQuery.of(context).size.height * 7) / 8,
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? (MediaQuery.of(context).size.width * 7) / 8
            : (MediaQuery.of(context).size.width * 7) / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: AssetImage(MediaQuery.of(context).orientation ==
                      Orientation.portrait
                  ? "assets/in_app_purchase_background/no_live_horizontal.png"
                  : "assets/in_app_purchase_background/no_live_vertical.png"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5),
                margin: const EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Text(
                    animalProvider.getUiTexts["refill lives"],
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "displayFont",
                      color: itemColor,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Consumer<LivesProvider>(
                  builder: (context, livesProvider, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 100,
                            color: Colors.red.withOpacity(.6),
                          ),
                          const Icon(
                            Icons.favorite,
                            size: 80,
                            color: Colors.red,
                          ),
                          Text(
                            Provider.of<LivesProvider>(context)
                                .getLive
                                .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          livesProvider.getLive == 5
                              ? "full"
                              : "${livesProvider.getRemainingMinutes} : ${livesProvider.getRemainingSeconds}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? isNotPortrait(context)
                  : isPortrait(context),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget isPortrait(context) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);
  LivesProvider livesProvider = Provider.of(context, listen: false);
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xff7dd505),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            top: 10,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/close_icon.png",
              color: Colors.white,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult != ConnectivityResult.none) {
            if (inAppPurchaseProvider.getGems > 200) {
              inAppPurchaseProvider
                  .setGemsValue(inAppPurchaseProvider.getGems - 200);
              final firebaseFirestore = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid);
              firebaseFirestore.update({"gems": inAppPurchaseProvider.getGems});
              livesProvider.setLive(5);
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
              buyGemWidget(context);
            }
          } else {
            showInformationSnackbar(
                context, animalProvider.getUiTexts["no internet connection"]);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff7dd505),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                animalProvider.getUiTexts["refill lives"],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.diamond,
                  size: 30,
                  color: itemColor,
                ),
              ),
              const Text(
                "200",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget isNotPortrait(context) {
  InAppPurchaseProvider inAppPurchaseProvider =
      Provider.of<InAppPurchaseProvider>(context, listen: false);
  LivesProvider livesProvider = Provider.of(context, listen: false);
  AnimalProvider animalProvider =
      Provider.of<AnimalProvider>(context, listen: false);
  return Column(
    children: [
      GestureDetector(
        onTap: () async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult != ConnectivityResult.none) {
            if (inAppPurchaseProvider.getGems > 200) {
              inAppPurchaseProvider.setGemsValue(inAppPurchaseProvider.getGems);
              final firebaseFirestore = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid);
              firebaseFirestore
                  .update({"gems": inAppPurchaseProvider.getGems - 200});
              livesProvider.setLive(5);
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
              buyGemWidget(context);
            }
          } else {
            showInformationSnackbar(
                context, animalProvider.getUiTexts["no internet connection"]);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff7dd505),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                animalProvider.getUiTexts["refill lives"],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.diamond,
                  size: 25,
                  color: itemColor,
                ),
              ),
              const Text(
                "200",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff7dd505),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/close_icon.png",
              color: Colors.white,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}
