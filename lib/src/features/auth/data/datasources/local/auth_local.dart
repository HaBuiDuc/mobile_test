import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'; // New Import

class AuthStorageKeys {
  static const String accessToken = 'ACCESS_TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';
}

abstract class AuthLocalDataSource {
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl(this._prefs); 

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _prefs.setString(AuthStorageKeys.accessToken, accessToken);
    await _prefs.setString(AuthStorageKeys.refreshToken, refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return _prefs.getString(AuthStorageKeys.accessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _prefs.getString(AuthStorageKeys.refreshToken);
  }
  
  @override
  Future<void> clearTokens() async {
    await _prefs.remove(AuthStorageKeys.accessToken);
    await _prefs.remove(AuthStorageKeys.refreshToken);
  }
}