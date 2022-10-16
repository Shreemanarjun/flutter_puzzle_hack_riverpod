import 'package:hive_flutter/hive_flutter.dart';

import 'i_storage_service.dart';

class StorageService implements IStorageService {
  Box hiveBox;

  StorageService({required this.hiveBox});

  @override
  Future<void> remove(String key) async {
    hiveBox.delete(key);
  }

  @override
  dynamic get(String key) {
    return hiveBox.get(key);
  }

  @override
  bool has(String key) {
    return hiveBox.containsKey(key);
  }

  @override
  Future<void> set(String? key, dynamic data) async {
    hiveBox.put(key, data);
  }

  @override
  Future<void> clear() async {
    await hiveBox.clear();
  }
}
