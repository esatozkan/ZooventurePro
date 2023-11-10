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

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                applicationData("Click Sale");
                inAppPurchaseWidget(context);
              },
              child: Image.asset(
                "assets/bottom_navbar_icon/gift.gif",
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                pageChangedProvider.getPageChanged == 0
                    ? animalProvider.getUiTexts[7]
                    : (pageChangedProvider.getPageChanged == 1)
                        ? animalProvider.getUiTexts[8]
                        : animalProvider.getUiTexts[9],
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "jokerman",
                  color: itemColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: GestureDetector(
                onTap: () async {
                  applicationData("Click Language Button");

                  if (pageChangedProvider.getPageChanged != 2) {
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
                                      child: Icon(
                                        Icons.close,
                                        color: itemColor,
                                        size: 35,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  color: Colors.transparent,
                                  height:
                                      (MediaQuery.of(context).size.height * 7) /
                                          8,
                                  width:
                                      (MediaQuery.of(context).size.width * 7) /
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
                                                animalProvider.getUiTexts[2] =
                                                    animalProvider
                                                        .getUiTexts[2];
                                                animalProvider.getUiTexts[3] =
                                                    animalProvider
                                                        .getUiTexts[3];
                                                animalProvider.getUiTexts[4] =
                                                    animalProvider
                                                        .getUiTexts[4];
                                              },
                                            );
                                          },
                                          child: Image.network(
                                            languageProvider
                                                .getLanguageService[index],
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
                  }
                },
                child: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, _) => CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: MemoryImage(
                        languageProvider.getLanguageServiceImage[
                            languageProvider.getFlagIndex],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
