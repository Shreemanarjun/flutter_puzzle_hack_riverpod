import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/puzzle_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/data/models/tile.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/widgets/pulse_transition.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/widgets/scale_up_transition.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/stop_watch_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/tile/tile_animated_positioned.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/tile/tile_content.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/tile/tile_gesture_detector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTileProvider = Provider<Tile>(
  (ref) => throw Exception("Current Tile is not updated"),
);

class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({Key? key}) : super(key: key);

  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScaleUpTransition(
        delay: AnimationsManager.bgLayerAnimationDuration,
        child: Consumer(
          builder: (context, ref, child) {
            final puzzle = ref.watch(puzzleProvider);

            return RawKeyboardListener(
              onKey: (event) {
                puzzle.handleKeyboardEvent(event);
                if (event is RawKeyDownEvent &&
                    puzzle.movesCount == 1 &&
                    keyboardListenerFocusNode.hasFocus) {
                  ref.read(stopWatchProvider.notifier).start();
                }
              },
              focusNode: keyboardListenerFocusNode,
              child: Builder(
                builder: (context) {
                  if (!keyboardListenerFocusNode.hasFocus) {
                    FocusScope.of(context)
                        .requestFocus(keyboardListenerFocusNode);
                  }
                  return Center(
                    child: SizedBox(
                      width: PuzzleLayout(context).containerWidth,
                      height: PuzzleLayout(context).containerWidth,
                      child: Stack(
                        children: List.generate(
                          puzzle.tilesWithoutWhitespace.length,
                          (index) {
                            Tile tile = puzzle.tilesWithoutWhitespace[index];
                            return ProviderScope(
                              overrides: [
                                currentTileProvider.overrideWithValue(tile)
                              ],
                              child: TileAnimatedPositioned(
                                isPuzzleSolved: puzzle.puzzle.isSolved,
                                puzzleSize: puzzle.n,
                                tileGestureDetector: TileGestureDetector(
                                  tileContent: PulseTransition(
                                    isActive:
                                        puzzle.puzzle.tileIsMovable(tile) &&
                                            !puzzle.puzzle.isSolved,
                                    child: TileContent(
                                      isPuzzleSolved: puzzle.puzzle.isSolved,
                                      puzzleSize: puzzle.n,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
