import 'dart:convert';
import 'package:ntp/ntp.dart';

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

  Future<Duration?> getAccessTokenRemainingTime(String token) async {
    final Map<String, dynamic> payload = parseJwt(token);
    final exp = payload['exp'] as int?;
    if (exp == null) {
      return null;
    }
    bool? isExpired = await isTokenExpired(token);
    DateTime currentNTPTime = await NTP.now();
    DateTime expToDateTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

    if (isExpired == true || currentNTPTime.isAfter(expToDateTime)) {
      // Token has expired
      return Duration.zero;
    } else {
      // Calculate remaining time as a Duration
      Duration remainingTime = expToDateTime.difference(currentNTPTime);
      return remainingTime;
    }
  }

  // returns current token, if token is expired
  // it returns a new token

}
