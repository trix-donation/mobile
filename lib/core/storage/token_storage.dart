import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static String? accessTokenKey;
  static String? _refreshTokenKey;

  bool isAuthorized = false;

  static const String _accessTokenStorageKey = "_accessToken";
  static const String _refreshTokenStorageKey = "_refreshToken";

  static const _serverEndpoint = "http://3.71.89.121/users/api";

  Future<void> checkAccessToken() async {
    // if (kDebugMode) {
    //   SharedPreferences.getInstance().then((value) => value.clear());
    // }

    _refreshTokenKey = await getRefreshToken();
    accessTokenKey = await getAccessToken();

    if (accessTokenKey == null && _refreshTokenKey == null) {
      isAuthorized = false;
      return;
    }

    if (accessTokenKey != null && _refreshTokenKey != null) {
      isAuthorized = true;
      return;
    }

    accessTokenKey ??= await updateAccessToken();
    return;
  }

  Future<String?> updateAccessToken() async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        "$_serverEndpoint/access_token_recovery",
        data: {
          "refresh_token": _refreshTokenKey,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data["access_token"];

        setAccessToken(accessToken);

        return accessToken;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> setAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_accessTokenStorageKey, accessToken);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_accessTokenStorageKey);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_refreshTokenStorageKey, refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_refreshTokenStorageKey);
  }
}
