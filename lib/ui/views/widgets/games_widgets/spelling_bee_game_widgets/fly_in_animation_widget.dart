import 'dart:math';
import 'package:flutter/material.dart';

class FlyInAnimationWidget extends StatefulWidget {
  const FlyInAnimationWidget({
    Key? key,
    required this.child,
    required this.animate,
    this.removeScale = false,
    this.animationCompleted,
  }) : super(key: key);

  final Widget child;
  final bool animate;
  final bool? removeScale;
  final Function? animationCompleted;

  @override
  State<FlyInAnimationWidget> createState() => _FlyInAnimationWidget();
}

class _FlyInAnimationWidget extends State<FlyInAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    controller = AnimationController(
      duration:const Duration(milliseconds: 600),
      vsync: this,
    );

    double begin = 0;
    double end = 0;
    final flip = Random().nextBool();
    if (flip) {
      begin = 1;
      end = 0;
    }

    rotationAnimation = Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutSine));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlyInAnimationWidget oldWidget) {
    if (widget.animate && !controller.isAnimating) {
      controller.reset();
      controller.forward();
      widget.animationCompleted?.call();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => RotationTransition(
        turns: rotationAnimation,
        child: (widget.removeScale ?? false)
            ? widget.child
            : ScaleTransition(
                scale: controller,
                child: widget.child,
              ),
      ),
    );
  }
}
