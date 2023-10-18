import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../widgets/games_widgets/memory_game_widgets/confetti_animation_widget.dart';
import '../../widgets/games_widgets/memory_game_widgets/generate_word.dart';
import '../../widgets/games_widgets/memory_game_widgets/memory_game_title_widget.dart';
import '../../widgets/games_widgets/memory_game_widgets/replay_widget.dart';
import '../../widgets/games_widgets/memory_game_widgets/word_model.dart';
import '../../widgets/games_widgets/memory_game_widgets/memory_games_provider.dart';
import '../../widgets/games_widgets/memory_game_widgets/word_tile.dart';

class MemoryGamesScreen extends StatefulWidget {
  const MemoryGamesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MemoryGamesScreen> createState() => _MemoryGamesScreen();
}

class _MemoryGamesScreen extends State<MemoryGamesScreen> {
  late final futureCacheImages;

  List<WordModel> gridWords = [];
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    futureCacheImages = cacheImages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final withPadding = size.width * .04;

    setUp(context);

    return Material(
      child: ChangeNotifierProvider(
        create: (_) => MemoryGamesProvider(),
        child: SafeArea(
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/games/memory_games/word_picture_memory_game_background.png"),
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
                  return Selector<MemoryGamesProvider, bool>(
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
                            const MemoryGamesTitleWidget(),
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
                                      childAspectRatio: .8,
                                    ),
                                    itemCount: 12,
                                    itemBuilder: (context, index) =>
                                        WordTileWidget(
                                      index: index,
                                      word: gridWords[index],
                                    ),
                                  ),
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

  setUp(context) {
    sourceWords.shuffle(Random());
    for (int i = 0; i < 6; i++) {
      gridWords.add(sourceWords[i]);

      gridWords.add(sourceWords[i]);
    }
    //  gridWords.shuffle(Random());
  }
}
