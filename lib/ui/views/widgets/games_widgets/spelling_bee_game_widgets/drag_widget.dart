import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/views/widgets/games_widgets/spelling_bee_game_widgets/spelling_bee_game_provider.dart';
import '../../../../../data/constants/constants.dart';

class DragWidget extends StatefulWidget {
  const DragWidget({
    Key? key,
    required this.letter,
  }) : super(key: key);

  final String letter;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Selector<SpellingBeeGameProvider, bool>(
      selector: (
        _,
        spellingBeeGameProvider,
      ) =>
          spellingBeeGameProvider.generateWord,
      builder: (_, generate, __) {
        if (generate) {
          accepted = false ;
        }
        return SizedBox(
          width: size.width * .15,
          height: size.height * .15,
          child: Center(
            child: accepted
                ? const SizedBox()
                : Draggable(
                    data: widget.letter,
                    onDragEnd: (details) {
                      if (details.wasAccepted) {
                        accepted = true;
                        setState(() {});
                        Provider.of<SpellingBeeGameProvider>(context,
                                listen: false)
                            .incrementLetters(context: context);
                      }
                    },
                    childWhenDragging:const SizedBox(),
                    feedback: Text(
                      widget.letter,
                      style: spellingBeeGameThemeData.textTheme.displayLarge
                          ?.copyWith(
                        shadows: [
                          Shadow(
                            offset:const Offset(3, 3),
                            color: Colors.black.withOpacity(.4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    child: Text(
                      widget.letter,
                      style: spellingBeeGameThemeData.textTheme.displayLarge,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
