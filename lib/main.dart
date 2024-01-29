import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onepref/onepref.dart';
import 'ui/providers/google_ads_provider.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_provider.dart';
import '/ui/views/screens/animated_splash_screen.dart';
import '/ui/providers/page_changed_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/providers/in_app_purchase_provider.dart';
import 'ui/providers/parent_control_provider.dart';
import 'ui/views/widgets/games_widgets/memory_game_widgets/memory_games_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  await OnePref.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (value) async {
      runApp(
        MultiProvider(
          providers: [
            ListenableProvider(
              create: (context) => PageChangedProvider(),
            ),
            ListenableProvider(
              create: (context) => QuestionGameProvider(),
            ),
            ListenableProvider(
              create: (_) => ParentControlProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => MemoryGamesProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => SpellingBeeGameProvider(),
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
