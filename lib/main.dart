import 'package:hive_flutter/hive_flutter.dart';
import '/data/models/animal_hive_adapter.dart';
import '/ui/providers/internet_connection_provider.dart';
import '/ui/providers/language_provider.dart';
import '/ui/views/screens/animated_splash_screen.dart';
import '/firebase_options.dart';
import '/ui/views/screens/noInternetConnection_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import '/ui/providers/page_changed_provider.dart';
import 'package:flutter/services.dart';
import '/ui/providers/animal_provider.dart';
import '/ui/providers/games_control_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Hive.deleteBoxFromDisk("Animals");
  // await Hive.deleteBoxFromDisk("flags");
  // await Hive.deleteBoxFromDisk("languages");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var connectivityResult = await Connectivity().checkConnectivity();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (value) async {
      if (connectivityResult == ConnectivityResult.none) {
        runApp(
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NoInternetConnection(),
          ),
        );
        main();
      } else {
        await Hive.initFlutter();
        Hive.registerAdapter(AnimalHiveAdapter());
        await Hive.openBox("Animals");
        await Hive.openBox("flags");
        await Hive.openBox("languages");
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
                create: (context) => GamesControlProvider(),
              ),
              ListenableProvider(
                create: (context) => LanguageProvider(),
              ),
              ListenableProvider(
                create: (context) => InternetConnectionProvider(),
              ),
              // ListenableProvider(
              //   create: (context) => WordPictureMemoryGameProvider(),
              // )
              ChangeNotifierProvider(
                create: (_) => WordPictureMemoryGameProvider(),
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
      home: const SplashScreen(),
    );
  }
}
