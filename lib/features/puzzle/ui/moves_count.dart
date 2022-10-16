import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MovesCount extends ConsumerWidget {
  const MovesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movesCount =
        ref.watch(puzzleProvider.select((value) => value.movesCount));
    return RichText(
      text: TextSpan(
        text: 'Moves: ',
        style: AppTextStyles.body.copyWith(color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: '$movesCount',
            style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
