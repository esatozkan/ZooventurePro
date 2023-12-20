import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onepref/onepref.dart';
import '/ui/providers/lives_provider.dart';
import '/data/models/animal_model.dart';
import '/data/services/google_ads.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_provider.dart';
import '/ui/providers/language_provider.dart';
import '/ui/views/screens/animated_splash_screen.dart';
import '/firebase_options.dart';
import '/ui/views/screens/noInternetConnection_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import '/ui/providers/page_changed_provider.dart';
import 'package:flutter/services.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/providers/in_app_purchase_provider.dart';
import 'ui/views/widgets/games_widgets/memory_game_widgets/memory_games_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  await OnePref.init();

  await Hive.initFlutter();
  Hive.registerAdapter(AnimalAdapter(), override: true);
  await Hive.openBox<Animal>("animals");
  await Hive.openBox<Animal>("buy24animals");
  await Hive.openBox<Animal>("buy36animals");
  await Hive.openBox("flags");
  await Hive.openBox("flagSpelling");
  await Hive.openBox<Map<dynamic, dynamic>>("languages");
  await Hive.openBox("internetConnection");
  await Hive.openBox("lives");
  await Hive.openBox<DateTime>("timer");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var connectivityResult = await Connectivity().checkConnectivity();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (value) async {
      if (connectivityResult == ConnectivityResult.none &&
          internetConnection.get(0) != true) {
        runApp(
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NoInternetConnection(),
          ),
        );
        main();
      } else {
        runApp(
          MultiProvider(
            providers: [
              ListenableProvider(
                create: (context) => AnimalProvider(),
              ),
              ListenableProvider(
                create: (context) => PageChangedProvider(),
              ),
              ListenableProvider(
                create: (context) => LanguageProvider(),
              ),
              ListenableProvider(
                create: (context) => QuestionGameProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => MemoryGamesProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => SpellingBeeGameProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => LivesProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => GoogleAdsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => InAppPurchaseProvider(),
              ),
            ],
            child: const MyApp(),
          ),
        );
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zooventure',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
