import 'package:get_storage/get_storage.dart';

import '../consts/storage_keys.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // ========================
  // Generic Methods
  // ========================

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }

  // ========================
  // Auth Specific Methods
  // ========================

  String? get token => read<String>(StorageKeys.authToken);

  Future<void> saveToken(String token) async {
    await write(StorageKeys.authToken, token);
  }

  Future<void> clearAuth() async {
    await remove(StorageKeys.authToken);
  }
}
