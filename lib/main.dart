import 'dart:io';
import 'package:dano_foosball/widgets/foosball_table/foosball_dashboard/foosball_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/models/auth/jwt_model.dart';
import 'package:dano_foosball/route_generator.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_theme.dart';
import 'package:dano_foosball/utils/preferences_service.dart';
import 'package:dano_foosball/widgets/Login.dart';
import 'package:dano_foosball/widgets/Settings.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:jwt_decode/jwt_decode.dart';
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

Future<void> setJwtInfo(String token) async {
  Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
  JwtModel jwtObject = JwtModel(
      name: decodedToken["unique_name"],
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

Future<void> setLanguageInfo() async {
  String? langFromStorage = await _getLanguageFromStorage();

  if (langFromStorage != null) {
    userState.setLanguage(langFromStorage);
  } else {
    userState.setLanguage("en");
  }
}

Future<void> setTheme() async {
  PreferencesService preferencesService = PreferencesService();
  bool? darkTheme = await preferencesService.getDarkTheme();

  if (darkTheme == true) {
    userState.setDarkmode(true);
  } else {
    userState.setDarkmode(false);
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");

  String theRoute = 'login';

  // Check if platform is desktop
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await setLanguageInfo();
    await setTheme();
    theRoute = 'foosball-dashboard';
  } else {
    String? tokenData = await _getJwtToken();
    if (tokenData != null) {
      await setJwtInfo(tokenData);
      await setLanguageInfo();
      await setTheme();
      theRoute = 'dashboard';
    }
  }

  runApp(MyApp(initialRoute: theRoute));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserState param = userState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      initialRoute: widget.initialRoute,
      routes: {
        'foosball-dashboard': (context) => FoosballDashboard(userState: param),
        'dashboard': (context) => NewDashboard(userState: param),
        'login': (context) => Login(userState: userState),
        'settings': (context) => Settings(userState: userState),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
