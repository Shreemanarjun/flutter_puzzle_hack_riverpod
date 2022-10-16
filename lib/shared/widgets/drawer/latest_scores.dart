import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/spacing.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/drawer/latest_score_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestScores extends ConsumerWidget {
  const LatestScores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scores = ref.watch(puzzleProvider.select((value) => value.scores));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).padding.left == 0
                  ? Spacing.md
                  : MediaQuery.of(context).padding.left,
              right: Spacing.screenHPadding,
              bottom: Spacing.xs,
            ),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.white.withOpacity(0.5), width: 0.5)),
            ),
            child: Text(
              'Latest Scores',
              style: AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (scores.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).padding.left == 0
                    ? Spacing.md
                    : MediaQuery.of(context).padding.left,
                right: Spacing.screenHPadding,
                top: Spacing.xs,
                bottom: Spacing.xs,
              ),
              child: const Text(
                  'Solve the puzzle to see your scores here! You can do it!'),
            ),
          ...List.generate(scores.length, (i) => LatestScoreItem(scores[i])),
        ],
      ),
    );
  }
}
