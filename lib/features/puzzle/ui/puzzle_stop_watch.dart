import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/helpers/duration_helper.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/stop_watch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PuzzleStopWatch extends ConsumerWidget {
  const PuzzleStopWatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatch = ref.watch(stopWatchProvider);
    Duration duration = Duration(seconds: stopwatch.secondsElapsed);

    return Text(
      DurationHelper.toFormattedTime(duration),
      style: AppTextStyles.bodyBold,
    );
  }
}
