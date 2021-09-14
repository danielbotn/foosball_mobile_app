import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foosball_mobile_app/models/auth/jwt_model.dart';
import 'package:foosball_mobile_app/models/auth/login_response.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  
  Future<LoginResponse> _authUser(LoginData data) async {
    try {
      var url = Uri.parse('https://localhost:5001/api/Auth/login');
      var body = jsonEncode( {
        'username': data.name,
        'password': data.password
      });

      var response = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

      if (response.statusCode == 200) {
        var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        return loginResponse;
      }
      throw Error();
    }
    catch(error) {
      throw error;
    }
    
  }
  
  test('jwt token is valid', () async {
    await dotenv.load(fileName: ".env");
    String? token = dotenv.env['JWT_TOKEN_TEST'];
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      JwtModel jwtObject = new JwtModel(
        name: decodedToken["name"], 
        currentOrganisationId: decodedToken["CurrentOrganisationId"], 
        nbf: decodedToken["nbf"], 
        exp: decodedToken["exp"], 
        iat: decodedToken["iat"]
      );
      expect(jwtObject.name, "4");
    }
  });
  
  test('login works', () async {
    String? username = dotenv.env['USERNAME_TEST'];
    String? password = dotenv.env['PASSWORD_TEST'];
    if (username != null && password != null) {
      LoginData loginData = new LoginData(name: username, password: password);
      LoginResponse loginResponse = await _authUser(loginData);
      expect(loginResponse.firstName, "Daniel");
      expect(loginResponse.lastName, "Sigurdsson");
      expect(loginResponse.email, "daniels@fakta.is");
      expect(loginResponse.token.length > 0, true);
    }
  });
}