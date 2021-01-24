import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prozone/utils/secure_store/session_storage_impl.dart';

class Application {
  SecureStorage _secureStorage;

  Application.instance()
    : _secureStorage =  new SecureStorage(
      storage: new FlutterSecureStorage()
  );

  Future<bool> getAuthToken() async {
    return await _secureStorage.contains("authToken");
  }

  Future<Map<String, dynamic>> getToken(String token) async {
    return await _secureStorage.get(token);
  }

  @override
  Future<void> setAuthToken(String key, Map<String, dynamic> data) {
    return _secureStorage.set(key, data);
  }

  @override
  Future<void> clearToken() {
    return _secureStorage.clearData();
  }

}