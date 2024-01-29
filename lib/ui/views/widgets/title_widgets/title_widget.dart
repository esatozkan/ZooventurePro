import '/data/repository/change_language.dart';
import '../../../../data/services/flags.dart';
import '/data/services/text_services.dart';
import '/ui/providers/parent_control_provider.dart';
import 'in_app_purchase_widgets/parent_control_widget.dart';
import '/ui/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constants/constants.dart';
import '../../../providers/page_changed_provider.dart';

bool isEN = true;

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

    final Size size = MediaQuery.of(context).size;

    return Positioned(
      top: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                Provider.of<ParentControlProvider>(context, listen: false)
                    .generateProcess();
                parentControlWidget(context);
              },
              child: Image.asset(
                "assets/bottom_navbar_icon/gift.gif",
                height: size.width < 800 ? 100 : 150,
                width: size.width < 800 ? 150 : 250,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                pageChangedProvider.getPageChanged == 0
                    ? texts["animal names"].toString()
                    : (pageChangedProvider.getPageChanged == 1)
                        ? texts["animal sounds"].toString()
                        : texts["games"].toString(),
                style: TextStyle(
                  fontSize: size.width < 800 ? 32 : 50,
                  fontFamily: "displayFont",
                  color: itemColor,
                  letterSpacing: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: pageChangedProvider.getPageChanged != 2
                  ? GestureDetector(
                      onTap: () async {
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
                                                height:
                                                    size.width < 1100 ? 50 : 80,
                                                width:
                                                    size.width < 1100 ? 50 : 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height:
                                          (MediaQuery.of(context).size.height *
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
                                          itemCount: flags.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                changeLanguage(index);
                                                pageChangedProvider
                                                    .setFlagIndex(index);
                                                Navigator.pop(context);
                                                setState(
                                                  () {
                                                    texts["games"] =
                                                        texts["games"]
                                                            .toString();
                                                    texts["animal names"] =
                                                        texts["animal names"]
                                                            .toString();
                                                    texts["animal sounds"] =
                                                        texts["animal sounds"]
                                                            .toString();
                                                    if (index == 1) {
                                                      isEN = true;
                                                    } else {
                                                      isEN = false;
                                                    }
                                                  },
                                                );
                                              },
                                              child: Image.asset(
                                                flags[index],
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
                      },
                      child: CircleAvatar(
                        radius: size.width < 1100 ? 30 : 50,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                            radius: size.width < 1100 ? 28 : 46,
                            backgroundImage: AssetImage(
                              flags[pageChangedProvider.getFlagIndex],
                            )),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
