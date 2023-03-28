import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:http/http.dart' as http;

class DatoCMS {
  DatoCMS();

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
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
