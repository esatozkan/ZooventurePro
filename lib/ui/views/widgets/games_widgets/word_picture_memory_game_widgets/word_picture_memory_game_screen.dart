// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/memory_game_title_widget.dart';
import '/ui/views/widgets/games_widgets/word_picture_memory_game_widgets/confetti_animation_widget.dart';
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
  late final futureCacheImages;

  List<WordModel> gridWords = [];
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    futureCacheImages = cacheImages();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int wordPictureMemoryGameProvider =
        Provider.of<WordPictureMemoryGameProvider>(context, listen: false)
            .getDifficulty;

    final size = MediaQuery.of(context).size;
    final withPadding = size.width * .04;

    setUp(context);

    return Material(
        child: ChangeNotifierProvider(
      create: (_) => WordPictureMemoryGameProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/memory_games/word_picture_memory_game_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder(
              future: futureCacheImages,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    color: Colors.deepPurple,
                    child: const Center(
                      child: Text(
                        "Error :( \n Check Your internet connection",
                        style: TextStyle(
                          fontFamily: "bubblegumSans",
                          fontSize: 40,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Selector<WordPictureMemoryGameProvider, bool>(
                  selector: (_, wordPictureMemoryGameProvider) =>
                      wordPictureMemoryGameProvider.roundCompleted,
                  builder: (_, roundCompleted, __) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) async {
                        if (roundCompleted) {
                          await showDialog(
                              barrierColor: Colors.transparent,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const ReplayWidget());
                        }
                      },
                    );

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const MemoryGameTitleWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
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
                                    itemCount: wordPictureMemoryGameProvider,
                                    itemBuilder: (context, index) => WordTile(
                                          index: index,
                                          word: gridWords[index],
                                        )),
                              ),
                              ConfettiAnimationWidget(animate: roundCompleted)
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    ));
  }

  Future<int> cacheImages() async {
    for (var w in gridWords) {
      final image = Image.network(w.url);
      await precacheImage(image.image, context);
    }
    return 1;
  }

  setUp(context) {
    int wordPictureMemoryGameProvider =
        Provider.of<WordPictureMemoryGameProvider>(context, listen: false)
            .getDifficulty;

    sourceWords.shuffle(Random());
    for (int i = 0; i < wordPictureMemoryGameProvider / 2; i++) {
      gridWords.add(sourceWords[i]);
      gridWords.add(
        WordModel(
          text: sourceWords[i].text,
          url: sourceWords[i].url,
          displayText: true,
        ),
      );
    }
    gridWords.shuffle(Random());
  }
}
