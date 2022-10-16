import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/background/widgets/background_stack.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/puzzle_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/features/dash/dash_rive_animation.dart';

import 'package:flutter_puzzle_hack_riverpod/features/phrases/animated_phrase_bubble.dart';
import 'package:flutter_puzzle_hack_riverpod/features/puzzle/board/puzzle_board.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/stop_watch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleView extends ConsumerStatefulWidget {
  const PuzzleView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends ConsumerState<PuzzleView> {
  late PuzzleProviderNotifier puzzle;
  late StopWatchProviderNotifier stopwatch;
  @override
  void initState() {
    puzzle = ref.read(puzzleProvider.notifier);
    stopwatch = ref.read(stopWatchProvider.notifier);
    if (puzzle.hasStarted) {
      stopwatch.start();
    }
    super.initState();
  }

  @override
  void dispose() {
    stopwatch.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PuzzleLayout puzzleLayout = PuzzleLayout(context);
    return Stack(
      children: [
        const BackgroundStack(),
        ...puzzleLayout.buildUIElements,
        PuzzleBoard(),
        const DashRiveAnimation(),
        const AnimatedPhraseBubble(),
      ],
    );
  }
}
