// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MatchedAnimationWidget extends StatefulWidget {
  const MatchedAnimationWidget({
    Key? key,
    required this.child,
    required this.animate,
    required this.numberOfWordAnswered,
  }) : super(key: key);

  final Widget child;
  final bool animate;
  final int numberOfWordAnswered;

  @override
  State<MatchedAnimationWidget> createState() => _MatchedAnimationWidgetState();
}

class _MatchedAnimationWidgetState extends State<MatchedAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> shake, scale;
  Color defaultColor = Colors.blueAccent, correctColor = Colors.green;
  bool correctColorIsSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    shake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.12), weight: 3),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.12, end: -0.08), weight: 5),
      TweenSequenceItem(
          tween: Tween<double>(begin: -0.08, end: 0.04), weight: 5),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.04, end: 0.00), weight: 6),
    ]).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.90), weight: 7),
      TweenSequenceItem(tween: Tween<double>(begin: 0.90, end: 1.0), weight: 3),
    ]).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant MatchedAnimationWidget oldWidget) {
    if (widget.animate) {
      if (!correctColorIsSet) {
        if (widget.numberOfWordAnswered == 4 ||widget.numberOfWordAnswered == 8) {
          correctColor = Colors.pink;
        }
        if (widget.numberOfWordAnswered == 6 || widget.numberOfWordAnswered == 12) {
          correctColor = Colors.amber;
        }
      }
      correctColorIsSet = true;
      controller.forward();
    }

    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
          ..rotateZ(shake.value)
          ..scale(scale.value)
          ..setEntry(3, 2, .003),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.animate ? correctColor : defaultColor,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
