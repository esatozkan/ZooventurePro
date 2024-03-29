import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../ui/providers/in_app_purchase_provider.dart';

class GoogleAdsProvider with ChangeNotifier {
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  int interstitialAdIndex = 0;
  int showInterstitialAdIndex = 7;

  void loadInterstitialAd({bool showAfterLoad = false, required context}) {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          if (showAfterLoad) {
            showInterstitialAd(context);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void showInterstitialAd(context) {
    InAppPurchaseProvider inAppPurchaseProvider =
        Provider.of<InAppPurchaseProvider>(context, listen: false);
    if (interstitialAd != null &&
        interstitialAdIndex == showInterstitialAdIndex - 1 &&
        inAppPurchaseProvider.getRemoveAdIsSubscribed == false &&
        inAppPurchaseProvider.getIsPremiumSubscribed == false) {
      interstitialAd!.show();
      interstitialAdIndex = 0;
      loadInterstitialAd(context: context);
    } else {
      if (inAppPurchaseProvider.getRemoveAdIsSubscribed == false &&
          inAppPurchaseProvider.getIsPremiumSubscribed == false) {
        interstitialAdIndex++;
      }
    }
    notifyListeners();
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }
}
