import 'package:dano_foosball/api/AuthApi.dart';
import 'package:dano_foosball/models/auth/jwt_model.dart';
import 'package:dano_foosball/models/auth/login_response.dart';
import 'package:dano_foosball/models/auth/error_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:io' show Platform;
import '../models/auth/register_response.dart';
import '../utils/preferences_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    final GoogleSignIn signIn = GoogleSignIn.instance;

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

      await handleDarkTheme();
      return null;
    } else if (loginData is ErrorResponse) {
      // Do something with the ErrorResponse
      return loginData.message;
    } else {
      // Handle unexpected response type
      return "unexpected error";
    }
  }

  Future handleDarkTheme() async {
    PreferencesService preferencesService = PreferencesService();
    bool? darkTheme = await preferencesService.getDarkTheme();

    if (darkTheme == null) {
      await preferencesService.setDarkTheme(true);
      widget.userState.setDarkmode(true);
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
      iat: decodedToken["iat"],
    );
    widget.userState.setUserId(loginResponse.id);
    // set current organisation id to mobx store if it is not null with tryParse
    if (jwtObject.currentOrganisationId != "") {
      widget.userState.setCurrentOrganisationId(
        int.parse(jwtObject.currentOrganisationId),
      );
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
      await loginUser(data);
      return null;
    } else {
      String errorMessage = "Could not verify email";
      return errorMessage;
    }
  }

  Future<void> _handleSuccessfulLogin(
    LoginResponse loginData,
    String? langFromStorage,
  ) async {
    PreferencesService preferencesService = PreferencesService();

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
    await handleDarkTheme();
  }

  Future<String?> _google() async {
    AuthApi auth = AuthApi();
    PreferencesService preferencesService = PreferencesService();
    String? langFromStorage = await preferencesService.getLanguage();
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;

     // Pick correct client ID based on platform
    final String clientId = Platform.isIOS
        ? '516082321577-dhuecsdffu1s0kc5057nqmpmq0b2ed1r.apps.googleusercontent.com' // iOS client ID
        : '516082321577-9n66a5i8o0udejlcsgod9qfue0gml2e4.apps.googleusercontent.com'; // Android client ID

    // Initialize first
    await signIn.initialize(clientId: clientId);

      // Check if authentication is supported on this platform
      if (signIn.supportsAuthenticate()) {
        await signIn.authenticate();

        // After authentication, request authorization for basic profile scopes
        const List<String> scopes = <String>[
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ];

        // This should give you access to user information
        final authorization = await signIn.authorizationClient
            .authorizationForScopes(scopes);

        if (authorization != null) {
          print('Authorization successful');
          print('Access Token: ${authorization.accessToken}');
          var loginData = await auth.google(authorization.accessToken);
          if (loginData is LoginResponse) {
            await _handleSuccessfulLogin(loginData, langFromStorage);
          } else if (loginData is ErrorResponse) {
            // Do something with the ErrorResponse
            return loginData.message;
          }
          // You can use the access token to make API calls to get user info
          // Or handle the successful authentication
          return null;
        }
      }

      return "Authentication not supported";
    } catch (error) {
      print('Google Sign-In error: $error');
      return error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        primaryColor: const Color(0xff94bd47),
        buttonTheme: LoginButtonTheme(backgroundColor: Colors.green[300]),
      ),
      logo: const AssetImage('assets/images/dano-scaled.png'),
      additionalSignupFields: [
        UserFormField(
          keyName: 'firstName',
          displayName: 'First name',
          fieldValidator: (value) {
            return null;
          },
        ),
        UserFormField(
          keyName: 'lastName',
          displayName: 'Last name',
          fieldValidator: (value) {
            return null;
          },
        ),
      ],
      // logo: 'assets/images/ecorp-lightblue.png',
      onLogin: loginUser,
      onSignup: _signupUser,
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            return await _google();
          },
          button: Buttons.google
        ),
      ],
      onRecoverPassword: _recoverPassword,
      onConfirmSignup: _signupConfirm,
      onSubmitAnimationCompleted: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewDashboard(userState: widget.userState),
          ),
        );
      },
    );
  }
}
