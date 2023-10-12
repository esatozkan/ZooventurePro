// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_provider.dart';
import 'package:zooventure/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_screen.dart';

class DifficultlySelectionWidget extends StatefulWidget {
  const DifficultlySelectionWidget({super.key});

  @override
  State<DifficultlySelectionWidget> createState() =>
      _DifficultlySelectionWidgetState();
}

class _DifficultlySelectionWidgetState
    extends State<DifficultlySelectionWidget> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/memory_games/word_picture_memory_game_background.png"),
          fit: BoxFit.cover,
          opacity: .6,
        ),
      ),
      child: ListView.builder(
        itemCount: difficultySelectionList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (index == 0) {
                  Provider.of<WordPictureMemoryGameProvider>(context,
                          listen: false)
                      .setValue(6);
                } else if (index == 1) {
                  Provider.of<WordPictureMemoryGameProvider>(context,
                          listen: false)
                      .setValue(8);
                } else {
                  Provider.of<WordPictureMemoryGameProvider>(context,
                          listen: false)
                      .setValue(12);
                }

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WordPictureMemoryGameScreen(),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: difficultySelectionList[index].secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          spreadRadius: .5,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: difficultySelectionList[index].primaryColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          spreadRadius: .3,
                          offset: Offset(5, 3),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            difficultySelectionList[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 2,
                                  offset: Offset(1, 2),
                                ),
                                Shadow(
                                  color: Colors.green,
                                  blurRadius: 2,
                                  offset: Offset(.5, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: generateStar(
                            difficultySelectionList[index].noOfStar,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> generateStar(int no) {
    List<Widget> icons = [];
    for (int i = 0; i < no; i++) {
      icons.insert(
        i,
        const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    }
    return icons;
  }
}

class Details {
  String name;
  Color primaryColor;
  Color secondaryColor;

  int noOfStar;

  Details({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.noOfStar,
  });
}

List<Details> difficultySelectionList = [
  Details(
    name: "EASY",
    primaryColor: Colors.green,
    secondaryColor: Colors.green.shade300,
    noOfStar: 1,
  ),
  Details(
    name: "MEDIUM",
    primaryColor: Colors.orange,
    secondaryColor: Colors.orange.shade300,
    noOfStar: 2,
  ),
  Details(
    name: "HARD",
    primaryColor: Colors.red,
    secondaryColor: Colors.red.shade300,
    noOfStar: 3,
  ),
];
