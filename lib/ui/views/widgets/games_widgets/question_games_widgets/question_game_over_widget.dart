// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooventure/ui/providers/animal_provider.dart';
import '/ui/views/screens/games/know_what_hear_screen.dart';
import '../../../screens/games/know_what_type_animal_screen.dart';
import '/ui/views/screens/games/know_what_virtual_animal_screen.dart';
import '../../../screens/games/know_what_real_animal_screen.dart';
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
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff01ddb3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xff01ddb3),
                      ),
                    ),
                    child: Text(
                      animalProvider.getUiTexts[3],
                      style: const TextStyle(
                        color: Color(0xffeb92e5),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "partyConfetti",
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    questionGameProvider.resetGame();
                    if (question == "knowWhatRealImage") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const KnowWhatRealAnimalScreen()),
                        (route) => false,
                      );
                    } else if (question == "knowWhatVirtualImage") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const KnowWhatVirtualAnimalScreen()),
                        (route) => false,
                      );
                    } else if (question == "knowWhatTypeAnimalScreen") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              const KnowWhatTypeAnimalScreen(),
                        ),
                        (route) => false,
                      );
                    } else if (question == "KnowWhatHearAnimalScreen") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              const KnowWhatHearAnimalScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff01ddb3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xff01ddb3),
                      ),
                    ),
                    child: Text(
                      animalProvider.getUiTexts[4],
                      style: const TextStyle(
                        color: Color(0xffeb92e5),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "partyConfetti",
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff01ddb3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xff01ddb3),
                      ),
                    ),
                    child: Text(
                      animalProvider.getUiTexts[5],
                      style: const TextStyle(
                        color: Color(0xffeb92e5),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "partyConfetti",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
