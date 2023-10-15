import '../widgets/games_widgets/spelling_bee_game_widgets/all_words_widget.dart';
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
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);
    InternetConnectionProvider internetConnectionProvider =
        Provider.of<InternetConnectionProvider>(context, listen: false);
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    internetConnectionProvider.getConnectivity(context);

    generateAnimal(context, languageProvider.getLocal);
    generateQuestions("knowWhatHear", 10, context);
    generateQuestions("knowWhatTypeAnimal", 10, context);
    generateQuestions("knowWhatRealAnimalImage", 10, context);
    generateQuestions("knowWhatVirtualAnimalImage", 10, context);

    populateSourceWords(context);

    spellingBeeGameGenerateAnimalWords(context);

    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        controller: pageController,
        onPageChanged: (index) {
          pageChangedProvider.pageChangedFunction(index);
        },
        itemBuilder: (context, index) => pages[index],
      ),
    );
  }
}
