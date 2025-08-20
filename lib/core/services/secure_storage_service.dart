import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageKeys {
  static const token = 'token';
  static const lang = 'lang';
}

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _write(SecureStorageKeys.token, token);
  }

  Future<String?> getToken() async {
    return await _read(SecureStorageKeys.token);
  }

  Future<void> deleteToken() async {
    await _delete(SecureStorageKeys.token);
  }

  Future<void> saveLang(String lang) async {
    await _write(SecureStorageKeys.lang, lang);
  }

  Future<String?> getLang() async {
    return await _read(SecureStorageKeys.lang);
  }

  Future<void> deleteLang() async {
    await _delete(SecureStorageKeys.lang);
  }

  Future<void> _write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      // TODO: handle or log error if needed
    }
  }

  Future<String?> _read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      // TODO: handle or log error if needed
      return null;
    }
  }

  Future<void> _delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      // TODO: handle or log error if needed
    }
  }
}
