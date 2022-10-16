import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/phrase_bubble_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/features/puzzle/board/puzzle_board.dart';
import 'package:flutter_puzzle_hack_riverpod/features/puzzle/share-dialog/puzzle_share_dialog.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/phrases_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/stop_watch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileGestureDetector extends ConsumerWidget {
  final Widget tileContent;

  const TileGestureDetector({
    Key? key,
    required this.tileContent,
  }) : super(key: key);

  Future<void> _showPuzzleSolvedDialog(
    BuildContext context,
    WidgetRef ref,
    int secondsElapsed,
  ) async {
    final puzzle = ref.read(puzzleProvider.notifier);
    await showDialog(
      context: context,
      builder: (c) {
        return PuzzleSolvedDialog(
          puzzleSize: puzzle.n,
          movesCount: puzzle.movesCount,
          solvingDuration: Duration(seconds: secondsElapsed),
        );
      },
    );
  }

  void _swapTilesAndUpdatePuzzle(BuildContext context, WidgetRef ref) {
    final puzzleNotifier = ref.read(puzzleProvider.notifier);
    final stopwatchNotifier = ref.read(stopWatchProvider.notifier);
    final phraseNotifier = ref.read(phraseProvider.notifier);
    final currentTile = ref.read(currentTileProvider);

    puzzleNotifier.swapTilesAndUpdatePuzzle(currentTile);

    // Handle Phrases
    if (puzzleNotifier.movesCount == 1) {
      stopwatchNotifier.start();
      phraseNotifier.setPhraseState(PhraseState.puzzleStarted);
    } else if (puzzleNotifier.puzzle.isSolved) {
      phraseNotifier.setPhraseState(PhraseState.puzzleSolved);
      Future.delayed(AnimationsManager.phraseBubbleTotalAnimationDuration, () {
        phraseNotifier.setPhraseState(PhraseState.none);
      });

      Future.delayed(AnimationsManager.puzzleSolvedDialogDelay, () {
        int secondsElapsed = stopwatchNotifier.secondsElapsed;
        stopwatchNotifier.stop();
        _showPuzzleSolvedDialog(
          context,
          ref,
          secondsElapsed,
        ).then((_) {
          puzzleNotifier.generate(forceRefresh: true);
        });
      });
    } else {
      if (phraseNotifier.phraseState != PhraseState.none) {
        if (phraseNotifier.phraseState == PhraseState.puzzleStarted ||
            phraseNotifier.phraseState == PhraseState.dashTapped ||
            phraseNotifier.phraseState == PhraseState.puzzleSolved) {
          Future.delayed(AnimationsManager.phraseBubbleTotalAnimationDuration,
              () {
            phraseNotifier.setPhraseState(PhraseState.none);
          });
        } else {
          phraseNotifier.setPhraseState(PhraseState.none);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzle = ref.watch(puzzleProvider);
    final tile = ref.watch(currentTileProvider);
    return IgnorePointer(
      ignoring: tile.tileIsWhiteSpace || puzzle.puzzle.isSolved,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          bool canMoveRight = details.velocity.pixelsPerSecond.dx >= 0 &&
              puzzle.puzzle.tileIsLeftOfWhiteSpace(tile);
          bool canMoveLeft = details.velocity.pixelsPerSecond.dx <= 0 &&
              puzzle.puzzle.tileIsRightOfWhiteSpace(tile);
          bool tileIsMovable = puzzle.puzzle.tileIsMovable(tile);
          if (tileIsMovable && (canMoveLeft || canMoveRight)) {
            _swapTilesAndUpdatePuzzle(context, ref);
          }
        },
        onVerticalDragEnd: (details) {
          bool canMoveUp = details.velocity.pixelsPerSecond.dy <= 0 &&
              puzzle.puzzle.tileIsBottomOfWhiteSpace(tile);
          bool canMoveDown = details.velocity.pixelsPerSecond.dy >= 0 &&
              puzzle.puzzle.tileIsTopOfWhiteSpace(tile);
          bool tileIsMovable = puzzle.puzzle.tileIsMovable(tile);
          if (tileIsMovable && (canMoveUp || canMoveDown)) {
            _swapTilesAndUpdatePuzzle(context, ref);
          }
        },
        onTap: () {
          bool tileIsMovable = puzzle.puzzle.tileIsMovable(tile);

          if (tileIsMovable) {
            _swapTilesAndUpdatePuzzle(context, ref);
          }
        },
        child: tileContent,
      ),
    );
  }
}
