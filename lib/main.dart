import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/route_generator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_theme.dart';
import 'package:foosball_mobile_app/utils/theme_notifier.dart';
import 'package:foosball_mobile_app/widgets/Login.dart';
import 'package:foosball_mobile_app/widgets/Settings.dart';
import 'package:foosball_mobile_app/widgets/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

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
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: "jwt_token");
  return value;
}

Future<String?> _getLanguageFromStorage() async {
  final storage = new FlutterSecureStorage();
  String? langFromStorage = await storage.read(key: "language");
  return langFromStorage;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  String? tokenData = await _getJwtToken();
  String theRoute = 'login';
  String? token = tokenData;
  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    JwtModel jwtObject = new JwtModel(
        name: decodedToken["name"],
        currentOrganisationId: decodedToken["CurrentOrganisationId"],
        nbf: decodedToken["nbf"],
        exp: decodedToken["exp"],
        iat: decodedToken["iat"]);
    // Putting userid and currentOrganisationId to mobx store
    userState.setUserId(int.parse(jwtObject.name));
    userState
        .setCurrentOrganisationId(int.parse(jwtObject.currentOrganisationId));
    userState.setToken(token);

    String? langFromStorage = await _getLanguageFromStorage();

    if (langFromStorage != null) {
      userState.setLanguage(langFromStorage);
    } else {
      userState.setLanguage("en");
    }

    bool isTokenExpired = JwtDecoder.isExpired(token);
    if (isTokenExpired == false) {
      theRoute = 'dashboard';
    }
  }

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (BuildContext context) {
        return ThemeNotifier(
          ThemeMode.dark,
        );
      },
      child: MyApp(initialRoute: theRoute),
    ),
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeNotifier.getThemeMode(),
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
