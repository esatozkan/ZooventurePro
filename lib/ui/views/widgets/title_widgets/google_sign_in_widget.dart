import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../data/services/user_service.dart';

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (auth.currentUser == null) {
          createUserInformationData(context);
        }
      },
      child: CircleAvatar(
        radius: size.width < 1100 ? 30 : 50,
        backgroundImage: const AssetImage("assets/sign_in_google.png"),
        foregroundImage: AssetImage(auth.currentUser == null
            ? "assets/games/question_games/question_game/wrong_answer.png"
            : "assets/games/question_games/question_game/correct_answer.png"),
      ),
    );
  }
}
