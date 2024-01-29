import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onepref/onepref.dart';
import 'package:provider/provider.dart';
import '/data/repository/get_information.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../../../data/constants/constants.dart';
import '/ui/views/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  IApEngine iApEngine = IApEngine();

  @override
  void initState() {
    super.initState();
    InAppPurchaseProvider inAppPurchaseProvider =
        Provider.of<InAppPurchaseProvider>(context, listen: false);

    inAppPurchaseProvider.restoreSubscription();

    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      if (list.isNotEmpty) {
        for (var element in list) {
          if (element.productID.contains("remove_ad_")) {
            //aboneliği yükle
            OnePref.setRemoveAds(true);
          }
          if (element.productID.contains("premium_")) {
            OnePref.setPremium(true);
          }
          if (element.productID.contains("buy_24_animal_")) {
            OnePref.setBool("isBuy24AnimalSubscribed", true);
          }
          if (element.productID.contains("buy_36_animal_")) {
            OnePref.setBool("isBuy36AnimalSubscribed", true);
          }
        }
      } else {
        // abonelik bulunmuyor ya da iptal edilmiş
        OnePref.setRemoveAds(false);
        OnePref.setPremium(false);
        OnePref.setBool("isBuy24AnimalSubscribed", false);
        OnePref.setBool("isBuy36AnimalSubscribed", false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen.withScreenFunction(
      backgroundColor: itemColor.withOpacity(.8),
      splash: "assets/splash_screen.gif",
      splashIconSize: size.width < 1100 ? 300 : 600,
      screenFunction: () async {
        getInformation(context);
        return const MainScreen();
      },
    );
  }
}
