import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectTilesCount extends StatelessWidget {
  const CorrectTilesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final puzzle = ref.watch(puzzleProvider);
        return RichText(
          text: TextSpan(
            text: 'Correct Tiles: ',
            style: AppTextStyles.body.copyWith(color: Colors.white),
            children: <TextSpan>[
              TextSpan(
                text:
                    '${puzzle.correctTilesCount}/${puzzle.puzzle.tiles.length - 1}',
                style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
