import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';

class DatoCMS {
  DatoCMS();

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    // PreferencesService preferencesService = PreferencesService();
    // String? token = await preferencesService.getJwtToken();
    late HardcodedStrings? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/Cms/hardcoded-strings?language=$language';
      try {
        final response = await Api().dio.post(
              url,
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                  // 'Authorization': 'Bearer $token',
                },
              ),
            );
        if (response.statusCode == 200) {
          var dta = HardcodedStrings.fromJson(response.data);
          result = dta;
        } else {
          print("else");
          result = null;
        }
      } catch (e) {
        print("catch");
        result = null;
      }
    }
    return result;
  }
}
