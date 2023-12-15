// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/lives_provider.dart';
import 'package:zooventure/ui/views/widgets/games_widgets/no_live_widget.dart';
import 'package:zooventure/ui/views/widgets/title_widgets/in_app_purchase_widgets/buy_gem_widget.dart';
import '/ui/providers/animal_provider.dart';
import '../../../../providers/page_changed_provider.dart';
import 'question_games_provider.dart';

// ignore: must_be_immutable
class QuestionGameGameOverWidget extends StatelessWidget {
  late String question;

  QuestionGameGameOverWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);
    LivesProvider livesProvider =
        Provider.of<LivesProvider>(context, listen: false);
    return Consumer<QuestionGameProvider>(
      builder: (context, questionGameProvider, _) => SingleChildScrollView(
        child: Visibility(
          visible: questionGameProvider.getQuestionIndex ==
                  questionGameProvider.getNumberOfQuestion
              ? true
              : false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/game_control/game_over.gif",
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                TextButton(
                  onPressed: () {
                    buyGemWidget(context);
                  },
                  child: textButton(animalProvider.getUiTexts["buy"], 60),
                ),
                TextButton(
                    onPressed: () {
                      if (livesProvider.getLive > 0) {
                        questionGameProvider.resetGame(context);
                        if (question == "knowWhatRealImage") {
                          pageChangedProvider.pageChangedFunction(4);
                        } else if (question == "knowWhatVirtualImage") {
                          pageChangedProvider.pageChangedFunction(6);
                        } else if (question == "knowWhatTypeAnimalScreen") {
                          pageChangedProvider.pageChangedFunction(5);
                        } else if (question == "KnowWhatHearAnimalScreen") {
                          pageChangedProvider.pageChangedFunction(3);
                        }
                      } else {
                        noLiveWidget(context);
                      }
                    },
                    child: textButton(animalProvider.getUiTexts["replay"], 40)),
                TextButton(
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]).then((value) {
                        pageChangedProvider.pageChangedFunction(2);
                      });
                    },
                    child: textButton(animalProvider.getUiTexts["quit"], 60)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textButton(String text, double horizontal) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff01ddb3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: const Color(0xff01ddb3),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xffeb92e5),
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: "partyConfetti",
        ),
      ),
    );
  }
}
