import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;

class Auth {
  Auth();

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
}
