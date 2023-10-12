// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/replay_widget.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_picture_memory_game_provider.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_model.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/generate_word.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/word_tile.dart';

class WordPictureMemoryGameScreen extends StatefulWidget {
  const WordPictureMemoryGameScreen({super.key});

  @override
  State<WordPictureMemoryGameScreen> createState() =>
      _WordPictureMemoryGameScreenState();
}

class _WordPictureMemoryGameScreenState
    extends State<WordPictureMemoryGameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final withPadding = size.width * .04;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/app_icon.png"), fit: BoxFit.cover)),
        child: FutureBuilder(
          future: cacheImages(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error :( \n Check Your internet connection",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Selector<WordPictureMemoryGameProvider, bool>(
              selector: (_, wordPictureMemoryGameProvider) =>
                  wordPictureMemoryGameProvider.roundCompleted,
              builder: (_, roundCompleted, __) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (roundCompleted) {
                    showDialog(
                        barrierColor: Colors.transparent,
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => ReplayWidget());
                  }
                });

                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/app_icon.png"),
                              fit: BoxFit.cover)),
                    ),
                    Center(
                      child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: withPadding, right: withPadding),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: .8),
                          itemCount: 12,
                          itemBuilder: (context, index) => WordTile(
                                index: index,
                                word: gridWords[index],
                              )),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<int> cacheImages() async {
    for (var w in gridWords) {
      final image = Image.network(w.url);
      await precacheImage(image.image, context);
    }
    return 1;
  }
}

List<WordModel> gridWords = [];

setUp() {
  sourceWords.shuffle(Random());
  for (int i = 0; i < 6; i++) {
    gridWords.add(sourceWords[i]);
    gridWords.add(
      WordModel(
        text: sourceWords[i].text,
        url: sourceWords[i].url,
        displayText: true,
      ),
    );
  }
  // gridWords.shuffle(Random());
}
