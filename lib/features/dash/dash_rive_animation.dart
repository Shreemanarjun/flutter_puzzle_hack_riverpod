import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/dash_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/phrase_bubble_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/phrases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rive/rive.dart';

final cantapDashProvider = StateProvider(
  (ref) => true,
);

class DashRiveAnimation extends StatefulWidget {
  const DashRiveAnimation({super.key});

  @override
  State<DashRiveAnimation> createState() => _DashRiveAnimationState();
}

class _DashRiveAnimationState extends State<DashRiveAnimation> {
  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'dashtronaut');

    artboard.addController(controller!);
  }

  @override
  Widget build(BuildContext context) {
    DashLayout dash = DashLayout(context);

    return Positioned(
        right: dash.position.right,
        bottom: dash.position.bottom,
        child: Consumer(
          builder: (context, ref, child) {
            final canTapDashNotifier = ref.read(cantapDashProvider.notifier);
            final phrasesNotifier = ref.read(phraseProvider.notifier);
            final canTapDash = ref.watch(cantapDashProvider);
            return GestureDetector(
              onTap: () {
                if (canTapDash) {
                  canTapDashNotifier.state = false;
                  phrasesNotifier.setPhraseState(PhraseState.dashTapped);
                  HapticFeedback.lightImpact();
                  Future.delayed(
                      AnimationsManager.phraseBubbleTotalAnimationDuration, () {
                    phrasesNotifier.setPhraseState(PhraseState.none);
                    canTapDashNotifier.state = true;
                  });
                }
              },
              child: child,
            );
          },
          child: SizedBox(
            width: dash.size.width,
            height: dash.size.height,
            child: RiveAnimation.asset(
              'assets/rive/dashtronaut.riv',
              onInit: _onRiveInit,
              stateMachines: const ['dashtronaut'],
            ),
          ),
        ));
  }
}
