import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';
import 'package:foosball_mobile_app/route_generator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/Login.dart';
import 'package:foosball_mobile_app/widgets/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final userState = UserState(); // Instantiate the store

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

 Future<String?> _getJwtToken() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "jwt_token");
    return value;
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
      iat: decodedToken["iat"]
    );
    // Putting userid and currentOrganisationId to mobx store
    userState.setUserId(int.parse(jwtObject.name));
    userState.setCurrentOrganisationId(int.parse(jwtObject.currentOrganisationId));
    userState.setToken(token);
  
    bool isTokenExpired = JwtDecoder.isExpired(token);
    if (isTokenExpired == false) {
      theRoute = 'dashboard';
    }
  }

  runApp(MyApp(initialRoute: theRoute));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DashboardParam param = DashboardParam(data: '', userState: userState);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff2980b9),
        backgroundColor: Colors.white
      ),
      initialRoute: widget.initialRoute,
      routes: {
        'dashboard': (context) => Dashboard(param: param, danni: 'dannidan'),
        'login': (context) => Login(userState: userState),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}