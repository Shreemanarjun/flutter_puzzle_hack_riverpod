import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/phrase_bubble_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_colors.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/phrases_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/stop_watch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleSizeItem extends StatelessWidget {
  final int size;

  const PuzzleSizeItem({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final stopwatchNotifier = ref.read(stopWatchProvider.notifier);
            final phraseNotifier = ref.read(phraseProvider.notifier);
            final puzzle = ref.read(puzzleProvider.notifier);
            bool isSelected = puzzle.n == size;
            return ElevatedButton(
              onPressed: () {
                if (!isSelected) {
                  puzzle.resetPuzzleSize(size);
                  stopwatchNotifier.stop();
                  if (size > 4) {
                    phraseNotifier
                        .setPhraseState(PhraseState.hardPuzzleSelected);
                  }
                  if (Scaffold.of(context).hasDrawer &&
                      Scaffold.of(context).isDrawerOpen) {
                    Navigator.of(context).pop();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(width: 1, color: Colors.white),
                ),
                minimumSize: const Size.fromHeight(50),
                backgroundColor: isSelected ? Colors.white : null,
              ),
              child: Text(
                '$size x $size',
                style: AppTextStyles.buttonSm.copyWith(
                    color: isSelected ? AppColors.primary : Colors.white),
              ),
            );
          },
        ),
        const SizedBox(height: 5),
        Text('${(size * size) - 1} Tiles', style: AppTextStyles.bodyXxs),
      ],
    );
  }
}
