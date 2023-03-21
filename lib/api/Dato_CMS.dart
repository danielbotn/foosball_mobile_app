import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/TokenHelper.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:http/http.dart' as http;

class DatoCMS {
  final String token;
  DatoCMS({required this.token});

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiryTwo();
    late HardcodedStrings? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url =
          Uri.parse('$baseUrl/api/Cms/hardcoded-strings?language=$language');
      var response = await http.post(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
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
