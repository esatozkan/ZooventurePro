// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAnimationWidget extends StatefulWidget {
  const ConfettiAnimationWidget({
    Key? key,
    required this.animate,
  }) : super(key: key);

  final bool animate;

  @override
  State<ConfettiAnimationWidget> createState() =>
      _ConfettiAnimationWidgetState();
}

class _ConfettiAnimationWidgetState extends State<ConfettiAnimationWidget> {
  final controller = ConfettiController(
    duration: Duration(milliseconds: 1500)
  );

  @override
  void didUpdateWidget(covariant ConfettiAnimationWidget oldWidget) {
    // TODO: implement didUpdateWidget

    if (widget.animate) {
      controller.play();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1.5),
      child: ConfettiWidget(
          maximumSize: Size(30, 100),
          minimumSize: Size(10, 30),
          gravity: .5,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 60,
          confettiController: controller),
    );
  }
}
