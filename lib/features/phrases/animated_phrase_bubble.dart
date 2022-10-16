import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/phrase_bubble_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/features/phrases/phrase_bubble.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/phrases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedPhraseBubble extends StatefulWidget {
  const AnimatedPhraseBubble({Key? key}) : super(key: key);

  @override
  State<AnimatedPhraseBubble> createState() => _AnimatedPhraseBubbleState();
}

class _AnimatedPhraseBubbleState extends State<AnimatedPhraseBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.phraseBubble.duration,
    );
    _scale = AnimationsManager.phraseBubble.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.phraseBubble.curve,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PhraseBubbleLayout phraseBubbleLayout = PhraseBubbleLayout(context);

    return Positioned(
      right: phraseBubbleLayout.position.right,
      bottom: phraseBubbleLayout.position.bottom,
      child: ScaleTransition(
        scale: _scale,
        alignment: Alignment.topRight,
        child: Consumer(
          builder: (context, ref, child) {
            final phrases = ref.watch(phraseProvider);
            if (phrases.phraseState == PhraseState.none) {
              return Container();
            } else {
              _animationController.forward();
              Future.delayed(
                AnimationsManager.phraseBubble.duration +
                    AnimationsManager.phraseBubbleHoldAnimationDuration,
                () {
                  _animationController.reverse();
                },
              );
              return PhraseBubble(state: phrases.phraseState);
            }
          },
        ),
      ),
    );
  }
}
