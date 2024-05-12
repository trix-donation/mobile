import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static String? accessTokenKey;
  static String? _refreshTokenKey;

  static bool isAuthorized = false;

  static const String _accessTokenStorageKey = "_accessToken";
  static const String _refreshTokenStorageKey = "_refreshToken";

  static const _serverEndpoint = "http://3.71.89.121/users/api";

  static Future<void> checkAccessToken() async {
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

    updateAccessToken();
    return;
  }

  static void updateAccessToken() async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        "http://3.71.89.121/users/api/access_token_recovery/",
        data: {
          "refresh_token": _refreshTokenKey,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data["access_token"];

        setAccessToken(accessToken);
      }
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> setAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessTokenKey = accessToken;
    prefs.setString(_accessTokenStorageKey, accessToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_accessTokenStorageKey);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _refreshTokenKey = refreshToken;
    prefs.setString(_refreshTokenStorageKey, refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_refreshTokenStorageKey);
  }
}
