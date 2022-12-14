import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';

class DrawerAppInfo extends StatelessWidget {
  const DrawerAppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Built with ',
        style: AppTextStyles.bodyXs.copyWith(color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: 'Flutter 💙',
            style: AppTextStyles.bodyXs.copyWith(fontWeight: FontWeight.w700),
          ),
          const TextSpan(
            text: ' for the ',
            style: AppTextStyles.bodyXs,
          ),
          TextSpan(
            text: 'Flutter Puzzle Hack',
            style: AppTextStyles.bodyXs.copyWith(fontWeight: FontWeight.w700),
          ),
          const TextSpan(
            text: ' Challenge',
            style: AppTextStyles.bodyXs,
          ),
        ],
      ),
    );
  }
}
