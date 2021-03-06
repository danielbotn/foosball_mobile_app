import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  AuthApi();

  Future<http.Response> login(LoginData data) async {
    late http.Response result;
    String? baseUrl = kReleaseMode ? dotenv.env['REST_URL_PATH_PROD'] : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/Auth/login');
      var body = jsonEncode( {
        'username': data.name,
        'password': data.password
      });

      result = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
    }
    return result;
  }

  // Register user
  // request body should be in the form of: { "email": "email", "password": "password", "firstName": "firstName", "lastName": "lastName" }
  Future<http.Response> register(SignupData data) async {
    late http.Response result;
    String? baseUrl = kReleaseMode ? dotenv.env['REST_URL_PATH_PROD'] : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/Auth/register');
      var body = jsonEncode( {
        'email': data.name,
        'password': data.password,
        'firstName': data.additionalSignupData!['firstName'],
        'lastName': data.additionalSignupData!['lastName']
      });

      result = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
    }
    return result;
  }

  // Verify email at route verify-email with token
  // this is a post request with token as a parameter
  Future<http.Response> verifyEmail(String token, int userId) async {
    late http.Response result;
    String? baseUrl = kReleaseMode ? dotenv.env['REST_URL_PATH_PROD'] : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/Auth/verify-email');
      var body = jsonEncode( {
        'token': token,
        'userId': userId
      });

      result = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
    }
    return result;
  }
}
