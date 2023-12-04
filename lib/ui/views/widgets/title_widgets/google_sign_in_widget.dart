import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zooventure/data/models/user_model.dart';
import 'package:zooventure/data/services/user_service.dart';

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return GestureDetector(
      onTap: () async {
        if (auth.currentUser == null) {
          signInWithGoogle();
          if (auth.currentUser != null) {
            setUserInformation();
          }
        }
      },
      child: CircleAvatar(
        radius: 30,
        backgroundImage: const AssetImage("assets/sign_in_google.png"),
        foregroundImage: AssetImage(auth.currentUser == null
            ? "assets/games/question_games/question_game/wrong_answer.png"
            : "assets/games/question_games/question_game/correct_answer.png"),
      ),
    );
  }
}
