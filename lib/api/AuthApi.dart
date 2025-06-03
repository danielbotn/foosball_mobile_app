import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/auth/error_response.dart';
import 'package:dano_foosball/models/auth/login_response.dart';
import 'package:dano_foosball/models/auth/refresh_model.dart';
import 'package:dano_foosball/models/auth/register_response.dart';
import 'package:dano_foosball/models/auth/update_password_request.dart';
import 'package:dano_foosball/models/auth/update_password_response.dart';
import 'package:dano_foosball/utils/helpers.dart';

class AuthApi {
  AuthApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<dynamic> login(LoginData data) async {
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

  Future<Response<dynamic>> refresh(RefreshModel data) async {
    late Response<dynamic> result;
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
    } on DioError catch (dioError) {
      // Handle DioError specifically
      if (dioError.response != null) {
        // The server responded with a status other than 2xx
        result = dioError.response!;
      } else {
        // Something happened in setting up or sending the request that triggered an error
        throw Exception('Failed to refresh token: ${dioError.message}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('An unexpected error occurred: $e');
    }

    return result;
  }

  // Register user
  // request body should be in the form of:
  //{ "email": "email", "password": "password", "firstName": "firstName", "r": "lastName" }
  Future<dynamic> register(SignupData data) async {
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

  Future<dynamic> google(String googleId) async {
    var url = '$baseUrl/api/Auth/google';
    try {
      final response = await Dio().post(
        url,
        data: {'googleId': googleId, 'platform': Platform.localeName},
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        return response.data.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Verify email at route verify-email with token
  // this is a post request with token as a parameter
  Future<Response> verifyEmail(String token, int userId) async {
    final dio = Dio();
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

  // Verify email at route verify-email with token
  // this is a post request with token as a parameter
  Future<Response> forgotPassword(String email) async {
    final dio = Dio();

    var url = '$baseUrl/api/Auth/forgot-password';

    try {
      final response = await dio.post(
        url,
        data: {
          'email': email,
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
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // TO DO
  Future<UpdatePasswordResponse?> updatePassword(
      UpdatePasswordRequest body) async {
    var url = '$baseUrl/api/Auth/update-password';

    var jsonObject = {
      "password": body.password,
      "confirmPassword": body.confirmPassword,
      "verificationCode":
          body.verificationCode == "" ? null : body.verificationCode
    };

    try {
      final response = await Api().dio.put(
            url,
            options: Options(
              headers: {
                "Accept": "application/json",
                "content-type": "application/json",
              },
            ),
            data: jsonEncode(jsonObject),
          );

      if (response.statusCode == 200) {
        return UpdatePasswordResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }
  }
}
