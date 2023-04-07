import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:foosball_mobile_app/models/auth/error_response.dart';
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:foosball_mobile_app/models/auth/refresh_model.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  AuthApi();

  Future<dynamic> login(LoginData data) async {
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/Auth/login';

      try {
        final response = await Dio().post(
          url,
          data: {'username': data.name, 'password': data.password},
          options: Options(
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! >= 200 && status <= 401;
            },
          ),
        );

        if (response.statusCode == 200) {
          return LoginResponse.fromJson(response.data);
        } else {
          return ErrorResponse(message: response.data);
        }
      } catch (e) {
        rethrow;
      }
    }

    throw Exception('Unable to perform login operation.');
  }

  Future<http.Response> refresh(RefreshModel data) async {
    late http.Response result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Auth/refresh');
      var body =
          jsonEncode({'token': data.token, 'refreshToken': data.refreshToken});

      result = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
    }
    return result;
  }

  // Register user
  // request body should be in the form of:
  //{ "email": "email", "password": "password", "firstName": "firstName", "r": "lastName" }
  Future<http.Response> register(SignupData data) async {
    late http.Response result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Auth/register');
      var body = jsonEncode({
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
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Auth/verify-email');
      var body = jsonEncode({'token': token, 'userId': userId});

      result = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
    }
    return result;
  }
}
