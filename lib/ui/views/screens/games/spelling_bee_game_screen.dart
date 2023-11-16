import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/page_changed_provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/fly_in_animation_widget.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/progress_bar_widget.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_title_widget.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/all_words_widget.dart';
import '../../widgets/games_widgets/spelling_bee_game_widgets/drag_widget.dart';
import '../../widgets/games_widgets/spelling_bee_game_widgets/drop_widget.dart';

class SpellingBeeGameScreen extends StatefulWidget {
  const SpellingBeeGameScreen({super.key});

  @override
  State<SpellingBeeGameScreen> createState() => _SpellingBeeGameScreenState();
}

class _SpellingBeeGameScreenState extends State<SpellingBeeGameScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageChangedProvider>(
        builder: (context, pageChangedProvider, _) {
      spellingBeeGameGenerateAnimalWords(context);

      List<String> words = allWords.map((e) => e.name).toList();
      List<Uint8List> images = allWords.map((e) => e.url).toList();

      late Uint8List image;
      late String word;
      late String dropWord;
      generateWord() {
        final r = Random().nextInt(words.length);

        word = words[r];
        image = images[r];
        dropWord = word;
        words.removeAt(r);
        images.removeAt(r);
        final s = word.characters.toList()..shuffle();
        word = s.join();

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<SpellingBeeGameProvider>(context, listen: false)
              .setup(total: word.length);
          Provider.of<SpellingBeeGameProvider>(context, listen: false)
              .requestWord(request: false);
        });
      }

      return Selector<SpellingBeeGameProvider, bool>(
        selector: (_, spellingBeeGameProvider) =>
            spellingBeeGameProvider.generateWord,
        builder: (_, generate, __) {
          if (generate) {
            if (words.isNotEmpty) {
              generateWord();
            }
          }
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  color: Colors.lightBlue,
                ),
                Column(
                  children: [
                    const Expanded(
                        flex: 3, child: SpellingBeeGameTitleWidget()),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: dropWord.characters
                            .map(
                              (e) => FlyInAnimationWidget(
                                animate: true,
                                child: DropWidget(
                                  letter: e,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: FlyInAnimationWidget(
                        animate: true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.memory(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: word.characters
                            .map(
                              (e) => FlyInAnimationWidget(
                                animate: true,
                                child: DragWidget(
                                  letter: e,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: ProgressBarWidget(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
