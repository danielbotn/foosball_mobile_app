import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:foosball_mobile_app/models/auth/error_response.dart';
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:foosball_mobile_app/models/auth/refresh_model.dart';
import 'package:foosball_mobile_app/models/auth/register_response.dart';

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

  Future<Response<dynamic>> refresh(RefreshModel data) async {
    late Response<dynamic> result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/Auth/refresh';

      try {
        result = await Dio().post(
          url,
          data: {'token': data.token, 'refreshToken': data.refreshToken},
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
      } catch (e) {
        rethrow;
      }
    }

    return result;
  }

  // Register user
  // request body should be in the form of:
  //{ "email": "email", "password": "password", "firstName": "firstName", "r": "lastName" }
  Future<dynamic> register(SignupData data) async {
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      var url = '$baseUrl/api/Auth/register';

      try {
        final response = await Dio().post(
          url,
          data: {
            'email': data.name,
            'password': data.password,
            'firstName': data.additionalSignupData!['firstName'],
            'lastName': data.additionalSignupData!['lastName']
          },
          options: Options(
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! >= 200 && status <= 500;
            },
          ),
        );

        if (response.statusCode == 201) {
          return RegisterResponse.fromJson(response.data);
        } else {
          return response.data.toString();
        }
      } catch (e) {
        rethrow;
      }
    }

    throw Exception('Unable to perform registration operation.');
  }

  // Verify email at route verify-email with token
  // this is a post request with token as a parameter
  Future<Response> verifyEmail(String token, int userId) async {
    final dio = Dio();
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/Auth/verify-email';

      try {
        final response = await dio.post(
          url,
          data: {'token': token, 'userId': userId},
          options: Options(
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! >= 200 && status <= 500;
            },
          ),
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }
    throw Exception('Unable to verify email.');
  }
}
