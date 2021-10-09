
import 'package:foosball_mobile_app/api/Auth.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:foosball_mobile_app/models/auth/error_response.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Login extends StatefulWidget {
  //props
  final UserState userState;
  Login({Key? key, required this.userState}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // State
  late DashboardParam dashboardData;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> loginUser(LoginData data) async {
    Auth auth = new Auth();
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "jwt_token");
    if (value != null) {
      await storage.delete(key: "jwt_token");
    }
    var loginData = await auth.login(data);

    if (loginData.statusCode != 200) {
      var error = ErrorResponse.fromJson(jsonDecode(loginData.body));
      return error.message;
    } else {
      var loginResponse = LoginResponse.fromJson(jsonDecode(loginData.body));
        await storage.write(key: "jwt_token", value: loginResponse.token);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(loginResponse.token);
        JwtModel jwtObject = new JwtModel(
          name: decodedToken["name"], 
          currentOrganisationId: decodedToken["CurrentOrganisationId"], 
          nbf: decodedToken["nbf"], 
          exp: decodedToken["exp"], 
          iat: decodedToken["iat"]
        );
        this.widget.userState.setUserId(loginResponse.id);
        this.widget.userState.setCurrentOrganisationId(int.parse(jwtObject.currentOrganisationId));
        this.widget.userState.setToken(loginResponse.token);
        dashboardData = DashboardParam(data: '', userState: this.widget.userState);
        return null;
    }
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
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
      onLogin: loginUser,
      onSignup: loginUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.pushNamed(
          context,
          'dashboard',
          arguments: dashboardData,
        );
      },
    );
  }
}
