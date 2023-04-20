import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';

class DatoCMS {
  DatoCMS();

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    late HardcodedStrings? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      try {
        var url = '$baseUrl/api/Cms/hardcoded-strings?language=$language';
        final response = await Api().dio.post(
              url,
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        if (response.statusCode == 200) {
          var dta = HardcodedStrings.fromJson(response.data);
          result = dta;
        } else {
          result = null;
        }
      } on DioError catch (e) {
        if (CancelToken.isCancel(e)) {
          // Request was cancelled
          rethrow;
        }
        rethrow;
      }
    }
    return result;
  }
}
