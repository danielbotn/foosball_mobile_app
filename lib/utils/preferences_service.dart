import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // get jwt token jwt_token using shared preferences package
  Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // get jwt token jwt_token using shared preferences package
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // set jwt token jwt_token using shared preferences package
  Future<void> setJwtToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt_token', token);
  }

  // delete jwt token jwt_token using shared preferences package
  Future<void> deleteJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
  }

  // sets refresh token using shared preferences package
  Future<void> setRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh_token', token);
  }

  // delete refresh token using shared preferences package
  Future<void> deleteRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('refresh_token');
  }

  // get language language using shared preferences package
  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  // set language language using shared preferences package
  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  // delete language language using shared preferences package
  Future<void> deleteLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('language');
  }

  // get dark_theme dark_theme using shared preferences package
  Future<bool?> getDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark_theme');
  }

  // set dark_theme dark_theme using shared preferences package
  Future<void> setDarkTheme(bool darkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark_theme', darkTheme);
  }

  // delete dark_theme dark_theme using shared preferences package
  Future<void> deleteDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('dark_theme');
  }
}
