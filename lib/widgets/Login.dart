
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:foosball_mobile_app/models/auth/error_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "jwt_token");
    if (value != null) {
      await storage.delete(key: "jwt_token");
    }

    String? baseUrl = kReleaseMode ? dotenv.env['REST_URL_PATH_PROD'] : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/Auth/login');
      var body = jsonEncode( {
        'username': data.name,
        'password': data.password
      });

      var response = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

      if (response.statusCode != 200) {
        var error = ErrorResponse.fromJson(jsonDecode(response.body));
        return error.message;
      }
      else {
        var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        await storage.write(key: "jwt_token", value: loginResponse.token);

        return null;
      }
    }
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "null";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
      primaryColor: Color(0xff2980b9),
      buttonTheme: LoginButtonTheme(
        backgroundColor: Colors.green[300]
      )
      ),
      title: 'FoosTab',
      // logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushNamed('dashboard');
      },
    );
  }
}
