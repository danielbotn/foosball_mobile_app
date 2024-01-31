import 'package:foosball_mobile_app/api/AuthApi.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:foosball_mobile_app/models/auth/error_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'dart:convert';
import 'package:foosball_mobile_app/widgets/dashboard/Dashboard.dart';
import 'package:foosball_mobile_app/widgets/dashboard/New_Dashboard.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../models/auth/register_response.dart';
import '../utils/preferences_service.dart';

class Login extends StatefulWidget {
  //props
  final UserState userState;
  const Login({Key? key, required this.userState}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // State
  late UserState dashboardData;
  late RegisterResponse registrationData;

  Future<String?> loginUser(LoginData data) async {
    AuthApi auth = AuthApi();
    PreferencesService preferencesService = PreferencesService();
    String? value = await preferencesService.getJwtToken();
    String? langFromStorage = await preferencesService.getLanguage();

    if (value != null) {
      await preferencesService.deleteJwtToken();
      await preferencesService.deleteRefreshToken();
    }
    var loginData = await auth.login(data);

    if (loginData is LoginResponse) {
      // Do something with the LoginResponse
      await preferencesService.setJwtToken(loginData.token);
      await preferencesService.setRefreshToken(loginData.refreshToken);
      setJwtInfo(loginData);

      if (langFromStorage != null) {
        widget.userState.setLanguage(langFromStorage);
      } else {
        await preferencesService.setLanguage('en');
        widget.userState.setLanguage('en');
      }
      dashboardData = widget.userState;
      return null;
    } else if (loginData is ErrorResponse) {
      // Do something with the ErrorResponse
      return loginData.message;
    } else {
      // Handle unexpected response type
      return "unexpected error";
    }
  }

  // void funciton
  void setJwtInfo(LoginResponse loginResponse) async {
    Map<String, dynamic> decodedToken = Jwt.parseJwt(loginResponse.token);
    JwtModel jwtObject = JwtModel(
        name: decodedToken["unique_name"],
        currentOrganisationId: decodedToken["CurrentOrganisationId"],
        nbf: decodedToken["nbf"],
        exp: decodedToken["exp"],
        iat: decodedToken["iat"]);
    widget.userState.setUserId(loginResponse.id);
    // set current organisation id to mobx store if it is not null with tryParse
    if (jwtObject.currentOrganisationId != "") {
      widget.userState
          .setCurrentOrganisationId(int.parse(jwtObject.currentOrganisationId));
    }
    widget.userState.setToken(loginResponse.token);
  }

  Future<String?> _recoverPassword(String name) async {
    AuthApi auth = AuthApi();
    var data = await auth.forgotPassword(name);
    if (data.statusCode == 200) {
      return null;
    } else {
      return "null";
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    AuthApi auth = AuthApi();

    var registerData = await auth.register(data);

    if (registerData is RegisterResponse) {
      registrationData = registerData;
      return null;
    } else {
      String errorMessage = "Could not register user";
      return errorMessage;
    }
  }

  Future<String?> _signupConfirm(String error, LoginData data) async {
    AuthApi auth = AuthApi();
    var verifyEmailData = await auth.verifyEmail(error, registrationData.id);

    if (verifyEmailData.statusCode == 200) {
      // login user
      loginUser(data);
      return null;
    } else {
      String errorMessage = "Could not verify email";
      return errorMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
          primaryColor: const Color(0xff94bd47),
          buttonTheme: LoginButtonTheme(backgroundColor: Colors.green[300])),
      logo: const AssetImage('assets/images/dano-scaled.png'),
      additionalSignupFields: [
        UserFormField(
            keyName: 'firstName',
            displayName: 'First name',
            fieldValidator: (value) {
              return null;
            }),
        UserFormField(
            keyName: 'lastName',
            displayName: 'Last name',
            fieldValidator: (value) {
              return null;
            })
      ],
      // logo: 'assets/images/ecorp-lightblue.png',
      onLogin: loginUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onConfirmSignup: _signupConfirm,
      onSubmitAnimationCompleted: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewDashboard(
                      userState: widget.userState,
                    )));
      },
    );
  }
}
