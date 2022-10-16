
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/screen_type_helper.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/spacing.dart';
import 'package:flutter_puzzle_hack_riverpod/features/puzzle/share-dialog/puzzle_score.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/dialogs/app_alert_dialog.dart';

class PuzzleSolvedDialog extends StatelessWidget {
  final int puzzleSize;
  final Duration solvingDuration;
  final int movesCount;

  const PuzzleSolvedDialog({
    Key? key,
    required this.puzzleSize,
    required this.solvingDuration,
    required this.movesCount,
  }) : super(key: key);

  String get imageName => 'solved-${puzzleSize}x$puzzleSize.png';

  @override
  Widget build(BuildContext context) {
    ScreenTypeHelper screenTypeHelper = ScreenTypeHelper(context);

    return AppAlertDialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHPadding, vertical: Spacing.md),
      content: screenTypeHelper.landscapeMode
          ? _landscapeContent
          : _portraitContent,
    );
  }

  Widget get _puzzleSolvedImage => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset('assets/images/puzzle-solved/$imageName'),
      );

  Widget get _puzzleScoreWidget => PuzzleScore(
        duration: solvingDuration,
        movesCount: movesCount,
        puzzleSize: puzzleSize,
      );

  Widget get _portraitContent => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _puzzleSolvedImage,
            const SizedBox(height: Spacing.sm),
            _puzzleScoreWidget,
          ],
        ),
      );

  Widget get _landscapeContent => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _puzzleSolvedImage),
          const SizedBox(width: Spacing.md),
          Expanded(flex: 4, child: _puzzleScoreWidget),
        ],
      );
}
