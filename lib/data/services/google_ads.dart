import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsProvider extends ChangeNotifier {
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  int interstitialAdIndex = 0;

  incrementInterstitialAdIndex() {
    interstitialAdIndex++;
    ChangeNotifier();
  }

  void loadInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          if (showAfterLoad) showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );

    notifyListeners();
  }

  void showInterstitialAd() {
    if (interstitialAd != null && interstitialAdIndex == 1) {
      interstitialAd!.show();
      interstitialAdIndex = 0;
      print("reklam yüklendi");
    }
    print("fonksiyona girildi");

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
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();

    notifyListeners();
  }
}
