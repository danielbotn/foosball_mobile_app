import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:http/http.dart' as http;

class DatoCMS {
  final String token;
  DatoCMS({required this.token});

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    late HardcodedStrings? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var json = {"language": 'is'};

      Uri outgoingUri = new Uri(
          scheme: 'https',
          host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
          port: kReleaseMode
              ? int.parse(dotenv.env['PROD_PORT'].toString())
              : int.parse(dotenv.env['DEV_PORT'].toString()),
          path: 'api/Cms/hardcoded-strings',
          queryParameters: json);

      var url = outgoingUri;
      var response = await http.post(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var dta = HardcodedStrings.fromJson(jsonDecode(response.body));
        result = dta;
      } else {
        result = null;
      }
    }
    return result;
  }
}
