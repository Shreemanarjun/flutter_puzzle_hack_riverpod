import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/puzzle_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/data/models/position.dart';
import 'package:flutter_puzzle_hack_riverpod/features/puzzle/board/puzzle_board.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileAnimatedPositioned extends ConsumerWidget {
  final bool isPuzzleSolved;
  final int puzzleSize;
  final Widget tileGestureDetector;

  const TileAnimatedPositioned({
    Key? key,
    required this.isPuzzleSolved,
    required this.puzzleSize,
    required this.tileGestureDetector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double tileWidth = PuzzleLayout(context).containerWidth / puzzleSize;
    final currentTile = ref.watch(currentTileProvider);
    Position tilePosition = currentTile.getPosition(context, tileWidth);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: tileWidth,
      height: tileWidth,
      left: tilePosition.left,
      top: tilePosition.top,
      child: tileGestureDetector,
    );
  }
}
