// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../screens/main_screen.dart';
import '/ui/providers/page_changed_provider.dart';
import '/data/repository/generate_question.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_title_widget.dart';
import 'question_game_over_widget.dart';

// ignore: must_be_immutable
class QuestionGameWidget extends StatefulWidget {
  QuestionGameWidget({
    Key? key,
    required this.question,
    required this.background,
  }) : super(key: key);

  late String question;
  late String background;

  @override
  State<QuestionGameWidget> createState() => _QuestionGameWidget();
}

class _QuestionGameWidget extends State<QuestionGameWidget> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    Provider.of<QuestionGameProvider>(context, listen: false)
        .resetGame(context);
    generateQuestion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    final Size size = MediaQuery.of(context).size;

    return Consumer<PageChangedProvider>(
        builder: (context, pageChangedProvider, _) {
      if (widget.question == "knowWhatTypeAnimalScreen") {
        audioPlayer.play(
          AssetSource(
            question[Provider.of<QuestionGameProvider>(context, listen: false)
                    .getQuestionIndex]
                .question
                .animalType,
          ),
        );
      } else if (widget.question == "KnowWhatHearAnimalScreen") {
        audioPlayer.play(
          AssetSource(
            question[Provider.of<QuestionGameProvider>(context, listen: false)
                    .getQuestionIndex]
                .question
                .animalVoice,
          ),
        );
      } else {
        googleAdsProvider.showInterstitialAd(context);
      }
      return SafeArea(
        child: Consumer<QuestionGameProvider>(
          builder: (context, questionGameProvider, _) => Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.background),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: QuestionTitleWidget(
                      question: widget.question,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: widget.question == "knowWhatVirtualImage" ||
                                widget.question == "knowWhatRealImage"
                            ? Image.asset(
                                widget.question == "knowWhatVirtualImage"
                                    ? question[
                                            Provider.of<QuestionGameProvider>(
                                                    context,
                                                    listen: false)
                                                .getQuestionIndex]
                                        .question
                                        .animalRealImage
                                    : question[
                                            Provider.of<QuestionGameProvider>(
                                                    context,
                                                    listen: false)
                                                .getQuestionIndex]
                                        .question
                                        .animalVirtualImage,
                                fit: BoxFit.cover,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: size.height < 1100 ? 150 : 300,
                                    width: size.height < 1100 ? 150 : 300,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffeb92e5)),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.question ==
                                            "knowWhatTypeAnimalScreen") {
                                          audioPlayer.play(
                                            AssetSource(
                                              question[questionGameProvider
                                                      .getQuestionIndex]
                                                  .question
                                                  .animalType,
                                            ),
                                          );
                                        } else {
                                          audioPlayer.play(
                                            AssetSource(
                                              question[questionGameProvider
                                                      .getQuestionIndex]
                                                  .question
                                                  .animalVoice,
                                            ),
                                          );
                                        }
                                      },
                                      child: const Icon(
                                        Icons.hearing,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      padding: const EdgeInsetsDirectional.all(20),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (questionGameProvider.getOnTap &&
                                    questionGameProvider.getQuestionIndex !=
                                        questionGameProvider
                                            .getNumberOfQuestion) {
                                  questionGameProvider.setIsVisibleListItem(
                                      index, true);
                                  if (widget.question ==
                                          "knowWhatVirtualImage" ||
                                      widget.question == "knowWhatRealImage") {
                                    await questionGameProvider.nextQuestion(
                                        index, context);
                                  } else {
                                    if (widget.question ==
                                        "knowWhatTypeAnimalScreen") {
                                      await questionGameProvider.nextQuestion(
                                          index, context,
                                          isVoice: "knowWhatTypeAnimalScreen");
                                    } else {
                                      await questionGameProvider.nextQuestion(
                                          index, context,
                                          isVoice: "KnowWhatHearAnimalScreen");
                                    }
                                  }
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  widget.question == "knowWhatVirtualImage" ||
                                          widget.question ==
                                              "knowWhatTypeAnimalScreen"
                                      ? question[questionGameProvider
                                              .getQuestionIndex]
                                          .option
                                          .keys
                                          .toList()[index]
                                          .animalVirtualImage
                                      : question[questionGameProvider
                                              .getQuestionIndex]
                                          .option
                                          .keys
                                          .toList()[index]
                                          .animalRealImage,
                                  height: size.height < 1100 ? 150 : 250,
                                  width: size.height < 1100 ? 150 : 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  questionGameProvider.getIsVisibleList[index],
                              child: Image.asset(
                                question[questionGameProvider.getQuestionIndex]
                                            .option
                                            .values
                                            .toList()[index] ==
                                        true
                                    ? "assets/games/question_games/question_game/correct_answer.png"
                                    : "assets/games/question_games/question_game/wrong_answer.png",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              QuestionGameGameOverWidget(
                question: widget.question,
              ),
            ],
          ),
        ),
      );
    });
  }
}
