import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

// This class represents a single bar in the equalizer visualization.
class EqualizerBar extends StatefulWidget {
  final AnimationController animationController;
  final double width;
  final double height;
  final Color color;

  const EqualizerBar({
    super.key,
    required this.animationController,
    required this.width,
    required this.height,
    this.color = Colors.black,
  });

  @override
  _EqualizerBarState createState() => _EqualizerBarState();
}

class _EqualizerBarState extends State<EqualizerBar>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    _curvedAnimation = CurvedAnimation(parent: widget.animationController, curve: Curves.easeInOutSine);
    _animation = Tween<double>(begin: 50, end: 100).animate(_curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Container(
            width: widget.width,
            height: _animation.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

// This class represents the entire equalizer visualization.
class Equalizer extends StatefulWidget {
  final List<AnimationController> animationControllers;
  final int numBars;
  final double barWidth;
  final double barHeight;
  final Color barColor;
  final Duration animationDuration;

  const Equalizer({
    super.key,
    required this.animationControllers,
    this.numBars = 10,
    this.barWidth = 6,
    this.barHeight = 30,
    this.barColor = Colors.black,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  _EqualizerState createState() => _EqualizerState();
}

class _EqualizerState extends State<Equalizer>
    with TickerProviderStateMixin {
  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.numBars,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: EqualizerBar(
          animationController: widget.animationControllers[index],
          width: widget.barWidth,
          height: widget.barHeight,
          color: widget.barColor,
        ),
            ),
      ),
    );
  }
}
