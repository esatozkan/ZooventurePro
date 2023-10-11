import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../../../data/services/flag_service.dart';
import '../../providers/internet_connection_provider.dart';
import '/ui/providers/language_provider.dart';
import '../../../data/constants/constants.dart';
import '/ui/views/screens/main_screen.dart';
import '../../../data/services/animal_service.dart';
import '../../../data/services/language_service.dart';
import '../../../data/services/text_services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var internetConnectionProvider =
        Provider.of<InternetConnectionProvider>(context);

    internetConnectionProvider.getConnectivity(context);
    return AnimatedSplashScreen.withScreenFunction(
      backgroundColor: itemColor.withOpacity(.8),
      splash: "assets/splash_screen.gif",
      splashIconSize: 300,
      screenFunction: () async {
        await getFirebase(context);
        return const MainScreen();
      },
    );
  }
}

Future getFirebase(context) async {
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);

  Box animalBox = Hive.box("Animals");

  if (animalBox.isEmpty) {
    await getAnimalGif(context);
    await getAnimalName(languageProvider.getLocal, context);
    await getAnimalVoice(context);
    await getAnimalRealImage(context);
    await getAnimalVirtualImage(context);
  }

  await getFlags(context);

  getLanguageFlag(
    languageProvider.getLocal,
    context,
  );

  await getText(
    languageProvider.getLocal,
    context,
  );
}
