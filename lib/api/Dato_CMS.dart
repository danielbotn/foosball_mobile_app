import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class DatoCMS {
  DatoCMS();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    late HardcodedStrings? result;

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

    return result;
  }
}
