import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _SharedPreferenceKeys {
  static const firstNameKey = 'name_key';
}

abstract class _SecureStorageKeys {
  static const tokenKey = 'token';
}

class SharedSecurityExampleModel {
  final _storage =
      SharedPreferences.getInstance(); // таким методом получаем хранилище
  final _secureStorage = FlutterSecureStorage(); // инициализация secure storage

  Future<void> readName() async {
    final storage = await _storage;
    final name = storage.getString(_SharedPreferenceKeys.firstNameKey);
    print(name);
  }

  Future<void> setName() async {
    final storage = await _storage;
    final name = storage.setString(_SharedPreferenceKeys.firstNameKey, 'Гоша');
  }

  Future<void> readToken() async {
    final token = await _secureStorage.read(key: _SecureStorageKeys.tokenKey);
    print(token);
  }

  Future<void> setToken() async {
    _secureStorage.write(
        key: _SecureStorageKeys.tokenKey, value: 'valuegck3ckc33k4c534kc53cg');
  }
}
