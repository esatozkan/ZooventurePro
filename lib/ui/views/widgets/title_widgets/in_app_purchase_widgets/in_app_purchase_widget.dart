import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zooventure/ui/providers/in_app_purchase_provider.dart';
import 'package:zooventure/ui/views/widgets/title_widgets/in_app_purchase_widgets/in_app_purchase_icon_widget.dart';
import 'package:zooventure/ui/views/widgets/title_widgets/in_app_purchase_widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../data/repository/generate_animal.dart';
import '/data/constants/constants.dart';
import '../../../../providers/animal_provider.dart';

class InAppPurchaseWidget extends StatefulWidget {
  const InAppPurchaseWidget({super.key});

  @override
  State<InAppPurchaseWidget> createState() => _InAppPurchaseWidgetState();
}

class _InAppPurchaseWidgetState extends State<InAppPurchaseWidget> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);

    List itemList = [
      InAppPurchaseIconWidget(
        image: "assets/purchases_icon/play_console_logo.png",
        text: animalProvider.getUiTexts.containsKey("other apps")
            ? animalProvider.getUiTexts["other apps"]
            : "Other Apps",
        onTap: () async {
          final Uri uri = Uri.parse(
              "https://play.google.com/store/apps/dev?id=8206297146535463722");
          if (await launchUrl(uri)) {
            await launchUrl(uri);
          }
        },
      ),
      Consumer<InAppPurchaseProvider>(
          builder: (context, inAppPurchaseProvider, _) {
        return InAppPurchaseIconWidget(
          image: "assets/purchases_icon/buy_24_animals.png",
          text: animalProvider.getUiTexts["buy 24 animals"],
          onTap: () {
            showModalBottomSheetWidget(context, 0);
          },
          isLoading: !inAppPurchaseProvider.getIsAll24AnimalInformationDownload,
        );
      }),
      Consumer<InAppPurchaseProvider>(
        builder: (context, inAppPurchaseProvider, _) => InAppPurchaseIconWidget(
          image: "assets/purchases_icon/buy_36_animals.gif",
          text: animalProvider.getUiTexts["buy 36 animals"],
          onTap: () {
            showModalBottomSheetWidget(context, 3);
          },
          isLoading: !inAppPurchaseProvider.getIsAll36AnimalInformationDownload,
        ),
      ),
      Consumer<InAppPurchaseProvider>(
        builder: (context, inAppPurchaseProvider, _) => InAppPurchaseIconWidget(
          image: "assets/purchases_icon/premium_icon.png",
          text: animalProvider.getUiTexts["buy premium"],
          onTap: () {
            showModalBottomSheetWidget(context, 9);
          },
          isLoading:
              (inAppPurchaseProvider.getIsAll36AnimalInformationDownload &&
                      inAppPurchaseProvider.getIsAll36AnimalInformationDownload)
                  ? false
                  : true,
        ),
      ),
      InAppPurchaseIconWidget(
        image: "assets/purchases_icon/play_with_ads.gif",
        text: animalProvider.getUiTexts["remove ads"],
        onTap: () {
          showModalBottomSheetWidget(context, 6);
        },
      ),
    ];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/purchases_icon/in_app_purchases_background_image.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).size.width < 800 ? 10 : 20),
                    child: GestureDetector(
                      onTap: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]).then((value) {
                          controlOfAddAnimalToApp(context);
                          Navigator.of(context).pop();
                        });
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: MediaQuery.of(context).size.width < 800 ? 30 : 50,
                        color: itemColor,
                      ),
                    ),
                  ),
                  Text(
                    animalProvider.getUiTexts["game store"],
                    style: TextStyle(
                        color: itemColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.of(context).size.width < 800 ? 23 : 45),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width < 800
                              ? 10
                              : 20),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: MediaQuery.of(context).size.width < 800 ? 30 : 50,
                        color: itemColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    itemCount: itemList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent:
                          MediaQuery.of(context).size.width < 800 ? 200 : 300,
                    ),
                    itemBuilder: (context, index) => itemList[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
