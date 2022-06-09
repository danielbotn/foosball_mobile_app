import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/route_generator.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_theme.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:foosball_mobile_app/widgets/Login.dart';
import 'package:foosball_mobile_app/widgets/Settings.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final userState = UserState(); // Instantiate the store

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<String?> _getJwtToken() async {
  PreferencesService preferencesService = PreferencesService();
  String? value = await preferencesService.getJwtToken();
  return value;
}

Future<String?> _getLanguageFromStorage() async {
  PreferencesService preferencesService = PreferencesService();
  String? value = await preferencesService.getLanguage();
  return value;
}

 void setJwtInfo(String token) async {
     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      JwtModel jwtObject = JwtModel(
          name: decodedToken["name"],
          currentOrganisationId: decodedToken["CurrentOrganisationId"],
          nbf: decodedToken["nbf"],
          exp: decodedToken["exp"],
          iat: decodedToken["iat"]);
      userState.setUserId(int.parse(jwtObject.name));
      // set current organisation id to mobx store if it is not null with tryParse
      if (jwtObject.currentOrganisationId != "") {
          userState
            .setCurrentOrganisationId(int.parse(jwtObject.currentOrganisationId));
      }
      userState.setToken(token);
  }

  void setLanguageInfo() async {
    String? langFromStorage = await _getLanguageFromStorage();

    if (langFromStorage != null) {
      userState.setLanguage(langFromStorage);
    } else {
      userState.setLanguage("en");
    }
  }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  String? tokenData = await _getJwtToken();
  String theRoute = 'login';
  String? token = tokenData;
  if (token != null) {
    setJwtInfo(token);
    setLanguageInfo();
    
    bool isTokenExpired = JwtDecoder.isExpired(token);
    if (isTokenExpired == false) {
      theRoute = 'dashboard';
    }
  }

  runApp(
    MyApp(initialRoute: theRoute),
  );
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserState param = userState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      initialRoute: widget.initialRoute,
      routes: {
        'dashboard': (context) => Dashboard(param: param),
        'login': (context) => Login(userState: userState),
        'settings': (context) => Settings(userState: userState),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
