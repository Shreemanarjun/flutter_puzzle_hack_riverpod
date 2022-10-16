import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/phrase_bubble_layout.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/spacing.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_colors.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/phrases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhraseBubble extends StatelessWidget {
  final PhraseState state;

  const PhraseBubble({
    Key? key,
    required this.state,
  })  : assert(state != PhraseState.none),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -12,
          top: -4,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: -21,
          top: -8,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: AppColors.primary),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md, vertical: Spacing.sm),
          constraints: const BoxConstraints(
            maxWidth: 180,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(width: 1, color: AppColors.primary),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              String phrase = ref.watch(phraseProvider).getPhrase(state);
              return Text(
                phrase,
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                  fontSize: phrase.length > 20 ? 16 : 20,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
