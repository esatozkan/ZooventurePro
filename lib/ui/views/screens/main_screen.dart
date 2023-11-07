import '../../../data/constants/constants.dart';
import '../../providers/animal_provider.dart';
import '../widgets/games_widgets/spelling_bee_game_widgets/all_words_widget.dart';
import '../widgets/on_boarding_control_widget.dart';
import '../widgets/title_widgets/title_widget.dart';
import '/ui/providers/language_provider.dart';
import '../widgets/games_widgets/memory_game_widgets/generate_word.dart';
import '/ui/providers/internet_connection_provider.dart';
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

PageController pageController = PageController(initialPage: 0);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    InternetConnectionProvider internetConnectionProvider =
        Provider.of<InternetConnectionProvider>(context, listen: false);
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    internetConnectionProvider.getConnectivity(context);

    generateAnimal(context, languageProvider.getLocal);

    generateQuestion(context);

    populateSourceWords(context);

    spellingBeeGameGenerateAnimalWords(context);


    AnimalProvider animalProvider=Provider.of<AnimalProvider>(context,listen: false);
    for(int i=0;i<animalProvider.getUiTexts.length;i++){
  print("***************");
  print(animalProvider.getUiTexts[i]);
}
    return Scaffold(
      body: Consumer<PageChangedProvider>(
        builder: (context, pageChangedProvider, _) => Stack(
          children: [
            screenBackgroundImage(
              pageChangedProvider.getPageChanged == 0
                  ? "assets/bottom_navbar_icon/animalsIcon.png"
                  : pageChangedProvider.getPageChanged == 1
                      ? "assets/bottom_navbar_icon/animalVoiceIcon.png"
                      : "assets/bottom_navbar_icon/gameScreenIcon.png",
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width,
            ),
            const OnBoardingControlWidget(),
            const TitleWidget(),
            Padding(
              padding: const EdgeInsets.only(
                left: 100,
                right: 100,
                top: 100,
              ),
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pages.length,
                controller: pageController,
                onPageChanged: (index) {
                  pageChangedProvider.pageChangedFunction(index);
                },
                itemBuilder: (context, index) => pages[pageChangedProvider.getPageChanged],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
