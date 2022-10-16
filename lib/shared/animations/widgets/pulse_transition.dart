import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/utils/animations_manager.dart';

class PulseTransition extends StatefulWidget {
  final Widget child;
  final bool isActive;
  const PulseTransition(
      {super.key, required this.child, required this.isActive});

  @override
  State<PulseTransition> createState() => _PulseTransitionState();
}

class _PulseTransitionState extends State<PulseTransition>  with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  void _runPulse() {
    if (widget.isActive) {
      _animationController.repeat(reverse: true);
    } else {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.pulse.duration,
    );
    _scale = AnimationsManager.pulse.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.pulse.curve,
      ),
    );
    _runPulse();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PulseTransition oldWidget) {
    _runPulse();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}

