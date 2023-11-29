import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onepref/onepref.dart';
import '/ui/providers/subscription_provider.dart';
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
  await Hive.openBox("flags");
  await Hive.openBox("flagSpelling");
  await Hive.openBox("languages");
  await Hive.openBox("internetConnection");
  await Hive.openBox("lives");

  // await Hive.deleteBoxFromDisk("animals");
  // await Hive.deleteBoxFromDisk("flags");
  // await Hive.deleteBoxFromDisk("languages");
  // await Hive.deleteBoxFromDisk("flagSpelling");
  //await Hive.deleteBoxFromDisk("lives");

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
              ChangeNotifierProvider(
                create: (_) => SubscriptionProvider(),
              )
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zooventure',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:

          //SplashScreenDeneme()
          const SplashScreen(),
    );
  }
}

class Deneme extends StatefulWidget {
  const Deneme({super.key});

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  @override
  void initState() {
    SubscriptionProvider subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();

    subscriptionProvider.getIApEngine.inAppPurchase.purchaseStream
        .listen((listOfPurchaseDetails) {
      if (listOfPurchaseDetails.isNotEmpty) {
        subscriptionProvider.updateSubExisting(true);
        subscriptionProvider.setOldPurchaseDetails(listOfPurchaseDetails[0]);
      }
      subscriptionProvider.listenPurchases(listOfPurchaseDetails);
    });

    subscriptionProvider.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    SubscriptionProvider subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Consumer<SubscriptionProvider>(
              builder: (context, subscriptionProvider, _) => Text(
                  "is subscriped ${subscriptionProvider.getIsSubscribeRemoveAd}")),
          Consumer<SubscriptionProvider>(
            builder: (context, subscriptionProvider, _) => Visibility(
                visible: !subscriptionProvider.getIsSubscribeRemoveAd,
                child: Text("showing ad")),
          ),
          Padding(
            padding: const EdgeInsets.all(27.0),
            child: GestureDetector(
                onTap: () {
                  subscriptionProvider.getIApEngine.inAppPurchase
                      .restorePurchases();
                },
                child: Text("Restore Subscription")),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: subscriptionProvider.getProductsList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () async {
                      subscriptionProvider.setRestore(false);
                      await subscriptionProvider.getIApEngine.inAppPurchase
                          .restorePurchases()
                          .whenComplete(() async {
                        await Future.delayed(Duration(seconds: 1))
                            .then((value) async {
                          if (subscriptionProvider.getSubExisting &&
                              subscriptionProvider
                                      .getOldPurchaseDetails.productID !=
                                  subscriptionProvider
                                      .getProductsList[index].id) {
                            await subscriptionProvider.getIApEngine
                                .upgradeOrDowngradeSubscription(
                                    subscriptionProvider.getOldPurchaseDetails,
                                    subscriptionProvider.getProductsList[index])
                                .then((value) {
                              subscriptionProvider.updateSubExisting(false);
                            });
                          } else {
                            subscriptionProvider.getIApEngine.handlePurchase(
                                subscriptionProvider.getProductsList[index],
                                subscriptionProvider.getStoreProductIds);
                          }
                        });
                      });
                    },
                    child: ListTile(
                      title: Text(subscriptionProvider
                          .getProductsList[index].description),
                      trailing: Text(
                          subscriptionProvider.getProductsList[index].price),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}

class SplashScreenDeneme extends StatefulWidget {
  const SplashScreenDeneme({super.key});

  @override
  State<SplashScreenDeneme> createState() => _SplashScreenDenemeState();
}

class _SplashScreenDenemeState extends State<SplashScreenDeneme> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<SubscriptionProvider>(context, listen: false)
        .restoreSubscription();

    Provider.of<SubscriptionProvider>(context, listen: false)
        .getIApEngine
        .inAppPurchase
        .purchaseStream
        .listen((list) {
      if (list.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          print(list[i].verificationData.localVerificationData);
        }
        OnePref.setRemoveAds(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => Deneme()));
      } else {
        //abonelik iptali ya da bitmesi durumu buraya yazılıcak
        OnePref.setRemoveAds(false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => Deneme()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("loading..."),
      ),
    );
  }
}
