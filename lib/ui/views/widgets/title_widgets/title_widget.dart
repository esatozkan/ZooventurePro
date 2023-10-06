import 'package:cached_network_image/cached_network_image.dart';
import '/ui/views/widgets/title_widgets/language_widgets/language_widget.dart';
import 'in_app_purchase_widgets/in_app_purchase_widget.dart';
import '/data/services/application_data_service.dart';
import '/ui/providers/language_provider.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constans/constans.dart';
import '../../../providers/page_changed_provider.dart';

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

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () async {
                applicationData("Click Sale");
                inAppPurchaseWidget(context);
              },
              icon: Image.asset(
                "assets/bottom_navbar_icon/gift.gif",
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                pageChangedProvider.getPageChanged == 0
                    ? animalProvider.getUiTexts[2]
                    : (pageChangedProvider.getPageChanged == 1)
                        ? animalProvider.getUiTexts[3]
                        : animalProvider.getUiTexts[4],
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "jokerman",
                  color: itemColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: context.dynamicSize(.026)),
              child: IconButton(
                onPressed: () async {
                  applicationData("Click Language Button");
                  languageWidget(context);

                  // setState(
                  //   () {
                  //      animalProvider.getUiTexts[2] =
                  //         animalProvider.getUiTexts[2];
                  //     animalProvider.getUiTexts[3] =
                  //         animalProvider.getUiTexts[3];
                  //     animalProvider.getUiTexts[4] =
                  //         animalProvider.getUiTexts[4];
                  //   },
                  // );
                  animalProvider.trueTextFunction();
                },
                icon: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, _) => CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: CachedNetworkImageProvider(
                        languageProvider
                            .getLanguageService[languageProvider.getFlagIndex],
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
