import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/ui/providers/in_app_purchase_provider.dart';
import '/ui/providers/lives_provider.dart';
import '../../../data/services/get_information.dart';
import '/data/services/google_ads.dart';
import '/ui/views/screens/games/know_what_hear_screen.dart';
import '/ui/views/screens/games/know_what_real_animal_screen.dart';
import '/ui/views/screens/games/know_what_type_animal_screen.dart';
import '/ui/views/screens/games/know_what_virtual_animal_screen.dart';
import '/ui/views/screens/games/memory_games_screen.dart';
import '/ui/views/screens/games/spelling_bee_game_screen.dart';
import '../../../data/constants/constants.dart';
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
    getAllInformation(context);
    Provider.of<LivesProvider>(context, listen: false).startCountDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InAppPurchaseProvider inAppPurchaseProvider =
        Provider.of<InAppPurchaseProvider>(context, listen: false);
    List<int> pageIndex = [0, 1, 2];
    return Scaffold(
      body: SafeArea(
        child: Consumer<PageChangedProvider>(
          builder: (context, pageChangedProvider, _) => pageIndex
                  .contains(pageChangedProvider.getPageChanged)
              ? Stack(
                  children: [
                    screenBackgroundImage(
                      pageChangedProvider.getPageChanged == 0
                          ? "assets/bottom_navbar_icon/animalsIcon.png"
                          : pageChangedProvider.getPageChanged == 1
                              ? "assets/bottom_navbar_icon/animalVoiceIcon.png"
                              : "assets/bottom_navbar_icon/gameScreenIcon.png",
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width,
                    ),
                    const OnBoardingControlWidget(),
                    const TitleWidget(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 100,
                        right: 100,
                        top: 100,
                        bottom: (googleAdsProvider.bannerAd != null &&
                                !inAppPurchaseProvider
                                    .getRemoveAdIsSubscribed &&
                                !inAppPurchaseProvider.getIsPremiumSubscribed)
                            ? googleAdsProvider.bannerAd!.size.height.toDouble()
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
                    Visibility(
                      visible: (googleAdsProvider.bannerAd != null &&
                              !inAppPurchaseProvider.getRemoveAdIsSubscribed &&
                              !inAppPurchaseProvider.getIsPremiumSubscribed)
                          ? true
                          : false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: googleAdsProvider.bannerAd != null
                              ? googleAdsProvider.bannerAd!.size.width
                                  .toDouble()
                              : 0,
                          height: googleAdsProvider.bannerAd != null
                              ? googleAdsProvider.bannerAd!.size.height
                                  .toDouble()
                              : 0,
                          child: googleAdsProvider.bannerAd != null
                              ? AdWidget(ad: googleAdsProvider.bannerAd!)
                              : const Text(""),
                        ),
                      ),
                    )
                  ],
                )
              : PageView.builder(
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
      ),
    );
  }
}
