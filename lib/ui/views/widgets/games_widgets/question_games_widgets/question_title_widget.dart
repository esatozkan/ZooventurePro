// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/ui/views/screens/games/know_what_type_animal_screen.dart';
import '../../../screens/games/know_what_hear_screen.dart';
import '../../../screens/games/know_what_real_animal_screen.dart';
import '../../../screens/games/know_what_virtual_animal_screen.dart';
import '/ui/views/widgets/games_widgets/question_games_widgets/question_games_provider.dart';

// ignore: must_be_immutable
class QuestionTitleWidget extends StatelessWidget {
  QuestionTitleWidget({
    Key? key,
    required this.question,
  }) : super(key: key);
  late String question;

  @override
  Widget build(BuildContext context) {
    QuestionGameProvider questionGameProvider =
        Provider.of(context, listen: false);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            },
            icon: Image.asset(
              "assets/game_control/back_icon.png",
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              color: const Color(0xffeb92e5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                questionGameProvider.resetGame();

                if (question == "knowWhatRealImage") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          const KnowWhatRealAnimalScreen(),
                    ),
                    (route) => false,
                  );
                } else if (question == "knowWhatVirtualImage") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          const KnowWhatVirtualAnimalScreen(),
                    ),
                    (route) => false,
                  );
                } else if (question == "knowWhatTypeAnimalScreen") {
                  Future.delayed(
                    const Duration(milliseconds: 1000),
                    () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              const KnowWhatTypeAnimalScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                } else if (question == "KnowWhatHearAnimalScreen") {
                  Future.delayed(
                    const Duration(milliseconds: 1000),
                    () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              const KnowWhatHearAnimalScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                }
              },
              icon: Image.asset(
                "assets/bottom_navbar_icon/gameScreenIcon.png",
                height: 60,
                width: 60,
                color: const Color(0xffeb92e5),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
