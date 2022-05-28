import 'package:foosball_mobile_app/api/AuthApi.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:foosball_mobile_app/models/auth/error_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'dart:convert';
import 'package:foosball_mobile_app/widgets/Dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../utils/preferences_service.dart';

class Login extends StatefulWidget {
  //props
  final UserState userState;
  Login({Key? key, required this.userState}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // State
  late UserState dashboardData;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> loginUser(LoginData data) async {
    AuthApi auth = AuthApi();
    PreferencesService preferencesService = new PreferencesService();
    String? value = await preferencesService.getJwtToken();
    String? langFromStorage = await preferencesService.getLanguage();
  
    if (value != null) {
      await preferencesService.deleteJwtToken();
    }
    var loginData = await auth.login(data);

    if (loginData.statusCode != 200) {
      var error = ErrorResponse.fromJson(jsonDecode(loginData.body));
      return error.message;
    } else {
      var loginResponse = LoginResponse.fromJson(jsonDecode(loginData.body));
      await preferencesService.setJwtToken(loginResponse.token);
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(loginResponse.token);
      JwtModel jwtObject = JwtModel(
          name: decodedToken["name"],
          currentOrganisationId: decodedToken["CurrentOrganisationId"],
          nbf: decodedToken["nbf"],
          exp: decodedToken["exp"],
          iat: decodedToken["iat"]);
      this.widget.userState.setUserId(loginResponse.id);
      this
          .widget
          .userState
          .setCurrentOrganisationId(int.parse(jwtObject.currentOrganisationId));
      this.widget.userState.setToken(loginResponse.token);

      if (langFromStorage != null) {
        this.widget.userState.setLanguage(langFromStorage);
      } else {
        await preferencesService.setLanguage('en');
        this.widget.userState.setLanguage('en');
      }
      dashboardData = this.widget.userState;
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
          buttonTheme: LoginButtonTheme(backgroundColor: Colors.green[300])),
      title: 'FoosTab',
      // logo: 'assets/images/ecorp-lightblue.png',
      onLogin: loginUser,
      // onSignup: loginUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      param: widget.userState,
                    )));
      },
    );
  }
}
