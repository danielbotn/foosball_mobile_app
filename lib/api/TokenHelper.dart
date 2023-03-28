import 'dart:convert';
import 'package:ntp/ntp.dart';
import '../models/auth/login_response.dart';
import '../models/auth/refresh_model.dart';
import '../utils/preferences_service.dart';
import 'AuthApi.dart';

class TokenHelper {
  //TESTING
  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += "==";
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64 string.');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw FormatException('Invalid token.');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw FormatException('Invalid payload.');
    }

    return payloadMap;
  }

  // This should work. Checks date from ntp server with date from token
  Future<bool?> isTokenExpired(String token) async {
    final Map<String, dynamic> payload = parseJwt(token);
    final exp = payload['exp'] as int?;
    if (exp == null) {
      return null;
    }
    try {
      DateTime currentNTPTime = await NTP.now();
      DateTime expToDateTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expToDateTime.isBefore(currentNTPTime);
    } catch (e) {
      // If there is an error with NTP synchronization, fall back to using the device time
      DateTime currentDeviceTime = DateTime.now();
      DateTime expirationDate =
          DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
      return expirationDate.isBefore(currentDeviceTime);
    }
  }

  // returns current token, if token is expired
  // it returns a new token
  Future<String> getToken() async {
    String tokenResult = '';
    PreferencesService preferencesService = PreferencesService();
    String? jwtToken = await preferencesService.getJwtToken();
    String? refreshToken = await preferencesService.getRefreshToken();

    if (jwtToken != null && refreshToken != null) {
      bool? isExpired = await isTokenExpired(jwtToken);

      if (isExpired == true) {
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
        print("TRUE TRUE TRUE");
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
        AuthApi auth = AuthApi();
        RefreshModel refreshModel =
            RefreshModel(token: jwtToken, refreshToken: refreshToken);
        var refreshData = await auth.refresh(refreshModel);

        if (refreshData.statusCode == 200) {
          var refreshResponse =
              LoginResponse.fromJson(jsonDecode(refreshData.body));

          await preferencesService.setJwtToken(refreshResponse.token);
          await preferencesService
              .setRefreshToken(refreshResponse.refreshToken);
          tokenResult = refreshResponse.token;
        } else {
          // log the user out!!
        }
      } else {
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
        print("FALSE FALSE FALSE");
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
        tokenResult = jwtToken;
      }
    }

    return tokenResult;
  }
}
