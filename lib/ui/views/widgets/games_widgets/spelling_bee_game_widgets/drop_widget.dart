import 'package:flutter/material.dart';
import '../../../../../data/constants/constants.dart';

class DropWidget extends StatelessWidget {
  const DropWidget({
    Key? key,
    required this.letter,
  }) : super(key: key);
  final String letter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool accepted = false;

    return SizedBox(
      width: size.width * .15,
      height: size.height * .15,
      child: Center(
        child: DragTarget(
          onWillAccept: (data) {
            if (data == letter) {
              return true;
            } else {
              return false;
            }
          },
          onAccept: (data) {
            accepted = true;
          },
          builder: (context, candidateData, rejectData) {
            if (accepted) {
              return Text(
                letter,
                style: spellingBeeGameThemeData.textTheme.displayLarge,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
                width: 50,
                height: 50,
              );
            }
          },
        ),
      ),
    );
  }
}
