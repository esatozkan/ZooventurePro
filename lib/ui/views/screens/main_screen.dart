import '../../../data/constants/constants.dart';
import '../../../data/services/animal_service.dart';
import '../widgets/on_boarding_control_widget.dart';
import '../widgets/title_widgets/title_widget.dart';
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

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    getAllInformation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (context, index) =>
                    pages[pageChangedProvider.getPageChanged],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
