import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/app.dart';
import 'package:flutter_puzzle_hack_riverpod/data/service/storage/storage_service.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final hiveBox = await Hive.openBox('dashtronaut');
  runApp(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(
          StorageService(hiveBox: hiveBox),
        )
      ],
      child: const App(),
    ),
  );
}
