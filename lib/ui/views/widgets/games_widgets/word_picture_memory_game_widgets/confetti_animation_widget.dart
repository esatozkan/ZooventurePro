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
  final controller =
      ConfettiController(duration: const Duration(milliseconds: 1500));

  @override
  void didUpdateWidget(covariant ConfettiAnimationWidget oldWidget) {
    if (widget.animate) {
      controller.play();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1.5),
      child: ConfettiWidget(
          maximumSize: const Size(30, 100),
          minimumSize: const Size(10, 30),
          gravity: .5,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 60,
          confettiController: controller),
    );
  }
}
