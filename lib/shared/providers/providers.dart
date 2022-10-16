import 'package:flutter_puzzle_hack_riverpod/data/service/storage/i_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider<IStorageService>(
  (ref) => throw Exception('Hive storage not initialized yet'),
);
