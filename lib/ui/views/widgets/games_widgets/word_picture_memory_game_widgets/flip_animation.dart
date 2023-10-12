// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class FlipAnimationWidget extends StatefulWidget {
  const FlipAnimationWidget({
    Key? key,
    required this.word,
    required this.animate,
    required this.reverse,
    required this.animatedCompleted,
    this.delay = 0,
  }) : super(key: key);

  final Widget word;
  final bool animate;
  final bool reverse;
  final Function(bool) animatedCompleted;
  final int delay;

  @override
  State<FlipAnimationWidget> createState() => _FlipAnimationWidgetState();
}

class _FlipAnimationWidgetState extends State<FlipAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            widget.animatedCompleted.call(true);
          }
          if (status == AnimationStatus.dismissed) {
            widget.animatedCompleted.call(false);
          }
        },
      );
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceInOut),
    );
  }

  @override
  void didUpdateWidget(covariant FlipAnimationWidget oldWidget) {
    // TODO: implement didUpdateWidget

    Future.delayed(
      Duration(milliseconds: widget.delay),
      () {
        if (mounted) {
          if (widget.animate) {
            if (widget.reverse) {
              controller.reverse();
            } else {
              controller.reset();
              controller.forward();
            }
          }
        }
      },
    );

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateY(animation.value * pi)
          ..setEntry(3, 2, .005),
        child: controller.value >= .5
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.word,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/app_icon.png",
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
