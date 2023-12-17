import 'package:firebase_auth/firebase_auth.dart';
import 'package:zooventure/data/services/user_service.dart';
import '/ui/views/widgets/title_widgets/google_sign_in_widget.dart';
import '/ui/views/screens/main_screen.dart';
import '/ui/views/widgets/internet_connection_widget.dart';
import '/ui/views/widgets/title_widgets/game_screen_title_widgets/game_screen_title_widget.dart';
import '/data/services/application_data_service.dart';
import '/ui/providers/language_provider.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constants/constants.dart';
import '../../../providers/page_changed_provider.dart';
import 'in_app_purchase_widgets/in_app_purchase_widget.dart';
import 'language_widgets/loading_widget.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context);
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    FirebaseAuth auth = FirebaseAuth.instance;

    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                if (animalProvider.getIsAllInformationDownload) {
                  if (auth.currentUser != null) {
                    applicationData("Click Sale");
                    // ignore: use_build_context_synchronously
                    inAppPurchaseWidget(context);
                  } else {
                    // ignore: use_build_context_synchronously
                    createUserInformationData(context);
                  }
                } else {
                  showInformationSnackbar(context, "loading the animal");
                }
              },
              child: Image.asset(
                "assets/bottom_navbar_icon/gift.gif",
                height: size.width < 1100 ? 100 : 150,
                width: size.width < 1100 ? 150 : 250,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                pageChangedProvider.getPageChanged == 0
                    ? animalProvider.getUiTexts["animal names"]
                    : (pageChangedProvider.getPageChanged == 1)
                        ? animalProvider.getUiTexts["animal sounds"]
                        : animalProvider.getUiTexts["games"],
                style: TextStyle(
                  fontSize: size.width < 1100 ? 32 : 50,
                  fontFamily: "displayFont",
                  color: itemColor,
                  letterSpacing: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: pageChangedProvider.getPageChanged == 0
                  ? GestureDetector(
                      onTap: () async {
                        if (animalProvider.getIsAllInformationDownload) {
                          applicationData("Click Language Button");

                          // ignore: use_build_context_synchronously
                          googleAdsProvider.showInterstitialAd(context);

                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (_) => Center(
                              child: Container(
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
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
                                                  color: itemColor,
                                                  height: size.width < 1100
                                                      ? 50
                                                      : 80,
                                                  width: size.width < 1100
                                                      ? 50
                                                      : 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                7) /
                                            8,
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    7) /
                                                8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(40.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 120,
                                              mainAxisSpacing: 20,
                                            ),
                                            itemCount: languageProvider
                                                .getLanguageService.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  languageProvider
                                                      .setFlagIndex(index);
                                                  // ignore: use_build_context_synchronously
                                                  await loadingWidget(context);

                                                  // ignore: use_build_context_synchronously
                                                  Navigator.pop(context);

                                                  setState(
                                                    () {
                                                      animalProvider.getUiTexts[
                                                              "games"] =
                                                          animalProvider
                                                                  .getUiTexts[
                                                              "games"];
                                                      animalProvider.getUiTexts[
                                                              "animal names"] =
                                                          animalProvider
                                                                  .getUiTexts[
                                                              "animal names"];
                                                      animalProvider.getUiTexts[
                                                              "animal sounds"] =
                                                          animalProvider
                                                                  .getUiTexts[
                                                              "animal sounds"];
                                                    },
                                                  );
                                                },
                                                child: Image.network(
                                                  languageProvider
                                                          .getLanguageService[
                                                      index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          showInformationSnackbar(
                              context, "loading the animal");
                        }
                      },
                      child: Consumer<AnimalProvider>(
                        builder: (context, animalProvider, _) =>
                            animalProvider.getIsAllInformationDownload == true
                                ? Consumer<LanguageProvider>(
                                    builder: (context, languageProvider, _) =>
                                        CircleAvatar(
                                      radius: size.width < 1100 ? 30 : 50,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: size.width < 1100 ? 28 : 46,
                                        backgroundImage: MemoryImage(
                                          languageProvider
                                                  .getLanguageServiceImage[
                                              languageProvider.getFlagIndex],
                                        ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: size.width < 1100 ? 30 : 50,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: size.width < 1100 ? 28 : 46,
                                      backgroundColor: itemColor,
                                      backgroundImage: const AssetImage(
                                          "assets/get_firebase_loading.gif"),
                                    ),
                                  ),
                      ),
                    )
                  : pageChangedProvider.getPageChanged == 1
                      ? const GoogleSignInWidget()
                      : const GameScreenTitleWidget(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
