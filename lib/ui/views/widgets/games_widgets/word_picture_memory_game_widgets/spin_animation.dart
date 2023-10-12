// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SpinAnimationWidget extends StatefulWidget {
  const SpinAnimationWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<SpinAnimationWidget> createState() => _SpinAnimationWidgetState();
}

class _SpinAnimationWidgetState extends State<SpinAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    Future.delayed(Duration(milliseconds: 600), () {
      if (mounted && !_controller.isAnimating) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
      child: RotationTransition(
        turns: CurvedAnimation(
          parent: _controller,
          curve: Curves.bounceInOut,
        ),
        child: widget.child,
      ),
    );
  }
}
