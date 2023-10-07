import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/repository/generate_animal.dart';
import '../../../data/repository/generate_question.dart';
import '/ui/providers/page_changed_provider.dart';
import '/ui/views/screens/animal_names_screen.dart';
import '/ui/views/screens/games_screen.dart';
import 'package:provider/provider.dart';
import '/ui/views/screens/listening_animals_screen.dart';
import 'package:flutter/material.dart';

List<Widget> pages = const [
  AnimalNamesScreen(),
  ListeningAnimalsScreen(),
  GamesScreen(),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

PageController pageController = PageController(initialPage: 0);

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  Connectivity connectivity = Connectivity();
  int count = 0;
  bool isAppActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  Future setDataCounter() async {
    final firebaseFirestore = FirebaseFirestore.instance
        .collection("application-data")
        .doc("countries");
    DocumentSnapshot snapshot = await firebaseFirestore.get();
    String country = Platform.localeName.split("_")[0];

    if (snapshot.exists && snapshot.data() != null) {
      Map<String, dynamic> countriesData =
          snapshot.data() as Map<String, dynamic>;

      if (countriesData.containsKey(country)) {
        firebaseFirestore.update(
          {
            country: FieldValue.increment(count),
          },
        );
      } else {
        firebaseFirestore.set(
          {
            country: count,
          },
        );
      }
      count = 0;
    }
  }

  Future setWhichCountry(context) async {
    final firebaseFirestore = FirebaseFirestore.instance
        .collection("application-data")
        .doc("countries-played");
    DocumentSnapshot snapshot = await firebaseFirestore.get();
    final localization = Localizations.localeOf(context).countryCode;

    if (snapshot.exists && snapshot.data() != null) {
      Map<String, dynamic> countriesPlayed =
          snapshot.data() as Map<String, dynamic>;
      if (countriesPlayed.containsKey(localization) == false) {
        firebaseFirestore.set(
          {
            localization.toString(): "true",
          },
        );
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      isAppActive = true;
    } else if (state == AppLifecycleState.inactive) {
      isAppActive = false;
      setDataCounter();
    } else if (state == AppLifecycleState.paused) {
      isAppActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);
    // var internetConnectionProvider =
    //     Provider.of<InternetConnectionProvider>(context);

    // internetConnectionProvider.getConnectivity(context);

    setWhichCountry(context);

    generateAnimal(context);
    generateQuestions("knowWhatHear", 10, context);
    generateQuestions("knowWhatTypeAnimal", 10, context);
    generateQuestions("knowWhatRealAnimalImage", 10, context);
    generateQuestions("knowWhatVirtualAnimalImage", 10, context);

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          controller: pageController,
          onPageChanged: (index) {
            pageChangedProvider.pageChangedFunction(index);
          },
          itemBuilder: (context, index) => pages[index],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
