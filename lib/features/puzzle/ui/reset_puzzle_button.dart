import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/core/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/animations/widgets/fade_in_transition.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/puzzle_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/phrases_provider/stop_watch_provider.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/dialogs/app_alert_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPuzzleButton extends ConsumerWidget {
  const ResetPuzzleButton({Key? key}) : super(key: key);

  void initResetPuzzle(BuildContext context, WidgetRef ref) {
    final puzzleNotifier = ref.read(puzzleProvider.notifier);
    final stopwatchNotifier = ref.read(stopWatchProvider.notifier);
    if (puzzleNotifier.hasStarted && !puzzleNotifier.puzzle.isSolved) {
      showDialog(
        context: context,
        builder: (context) {
          return AppAlertDialog(
            title: 'Are you sure you want to reset your puzzle?',
            onConfirm: () {
              stopwatchNotifier.stop();
              puzzleNotifier.generate(forceRefresh: true);
            },
          );
        },
      );
    } else {
      stopwatchNotifier.stop();
      puzzleNotifier.generate(forceRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FadeInTransition(
        delay: AnimationsManager.bgLayerAnimationDuration,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () => initResetPuzzle(context, ref),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.refresh),
                SizedBox(width: 7),
                Text('Reset', style: AppTextStyles.button),
              ],
            ),
          ),
        ));
  }
}
