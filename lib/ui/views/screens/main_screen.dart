import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '../../providers/google_ads_provider.dart';
import '/ui/views/screens/games/know_what_hear_screen.dart';
import '/ui/views/screens/games/know_what_real_animal_screen.dart';
import '/ui/views/screens/games/know_what_type_animal_screen.dart';
import '/ui/views/screens/games/know_what_virtual_animal_screen.dart';
import '/ui/views/screens/games/memory_games_screen.dart';
import '/ui/views/screens/games/spelling_bee_game_screen.dart';
import '../widgets/on_boarding_control_widget.dart';
import '../widgets/title_widgets/title_widget.dart';
import '/ui/providers/page_changed_provider.dart';
import '/ui/views/screens/animal_names_screen.dart';
import '/ui/views/screens/games_screen.dart';
import 'package:provider/provider.dart';
import '/ui/views/screens/listening_animals_screen.dart';
import 'package:flutter/material.dart';

List<Widget> pages = const [
  AnimalNamesScreen(),
  ListeningAnimalsScreen(),
  GamesScreen(),
  KnowWhatHearAnimalScreen(),
  KnowWhatRealAnimalScreen(),
  KnowWhatTypeAnimalScreen(),
  KnowWhatVirtualAnimalScreen(),
  MemoryGamesScreen(),
  SpellingBeeGameScreen(),
];

PageController pageController = PageController(initialPage: 0);

GoogleAdsProvider googleAdsProvider = GoogleAdsProvider();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    googleAdsProvider.loadBannerAd();
    googleAdsProvider.loadInterstitialAd(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InAppPurchaseProvider inAppPurchaseProvider =
        Provider.of<InAppPurchaseProvider>(context, listen: false);

    List<int> pageIndex = [0, 1, 2];

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/bottom_navbar_icon/screensBackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Consumer<PageChangedProvider>(
            builder: (context, pageChangedProvider, _) => pageIndex
                    .contains(pageChangedProvider.getPageChanged)
                ? Stack(
                    children: [
                      const OnBoardingControlWidget(),
                      const TitleWidget(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width < 1100 ? 100 : 150,
                          right: size.width < 1100 ? 100 : 150,
                          top: size.width < 1100 ? 100 : 150,
                          bottom:
                              (googleAdsProvider.getIsBannerAdLoaded != false &&
                                      !inAppPurchaseProvider
                                          .getIsPremiumSubscribed &&
                                      !inAppPurchaseProvider
                                          .getIsRemoveAdSubscribed)
                                  ? googleAdsProvider.bannerAd!.size.height
                                      .toDouble()
                                  : 0,
                        ),
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pages.length,
                          controller: pageController,
                          onPageChanged: (index) {
                            pageChangedProvider.pageChangedFunction(
                                pageChangedProvider.getPageChanged);
                          },
                          itemBuilder: (context, index) =>
                              pages[pageChangedProvider.getPageChanged],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child:
                                (googleAdsProvider.getIsBannerAdLoaded !=
                                            false &&
                                        !inAppPurchaseProvider
                                            .getIsRemoveAdSubscribed &&
                                        !inAppPurchaseProvider
                                            .getIsPremiumSubscribed)
                                    ? AdWidget(ad: googleAdsProvider.bannerAd!)
                                    : const Text(""),
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              (googleAdsProvider.getIsBannerAdLoaded != false &&
                                      !inAppPurchaseProvider
                                          .getIsPremiumSubscribed &&
                                      !inAppPurchaseProvider
                                          .getIsRemoveAdSubscribed)
                                  ? googleAdsProvider.bannerAd!.size.height
                                      .toDouble()
                                  : 0,
                        ),
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pages.length,
                          controller: pageController,
                          onPageChanged: (index) {
                            pageChangedProvider.pageChangedFunction(
                                pageChangedProvider.getPageChanged);
                          },
                          itemBuilder: (context, index) =>
                              pages[pageChangedProvider.getPageChanged],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child:
                                (googleAdsProvider.getIsBannerAdLoaded !=
                                            false &&
                                        !inAppPurchaseProvider
                                            .getIsRemoveAdSubscribed &&
                                        !inAppPurchaseProvider
                                            .getIsPremiumSubscribed)
                                    ? AdWidget(ad: googleAdsProvider.bannerAd!)
                                    : const Text(""),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
