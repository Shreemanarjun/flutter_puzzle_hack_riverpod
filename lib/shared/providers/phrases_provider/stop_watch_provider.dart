import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack_riverpod/data/service/storage/i_storage_service.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stopWatchProvider =
    ChangeNotifierProvider<StopWatchProviderNotifier>((ref) {
  return StopWatchProviderNotifier(ref.read(storageProvider))..init();
});

class StopWatchProviderNotifier extends ChangeNotifier {
  Stream<int> timeStream =
      Stream.periodic(const Duration(seconds: 1), (x) => 1 + x++);

  final IStorageService storageService;

  StopWatchProviderNotifier(this.storageService);

  StreamSubscription<int>? streamSubscription;

  int secondsElapsed = 0;

  void init() {
    secondsElapsed = storageService.get(StorageKey.secondsElapsed) ?? 0;
  }

  void start() {
    if (streamSubscription != null && streamSubscription!.isPaused) {
      streamSubscription!.resume();
    } else {
      streamSubscription = timeStream.listen((seconds) {
        secondsElapsed++;
        notifyListeners();
        storageService.set(StorageKey.secondsElapsed, secondsElapsed);
      });
    }
  }

  void stop() {
    if (streamSubscription != null && !streamSubscription!.isPaused) {
      streamSubscription!.pause();
      secondsElapsed = 0;
      notifyListeners();
      storageService.set(StorageKey.secondsElapsed, secondsElapsed);
    }
  }

  void cancel() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }
}
