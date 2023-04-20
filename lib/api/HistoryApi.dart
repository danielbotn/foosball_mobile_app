import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/history/historyModel.dart';
import 'package:foosball_mobile_app/models/history/userStats.dart';

class HistoryApi {
  HistoryApi();

  Future<UserStats?> getStats() async {
    UserStats? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      var url = Uri(
        scheme: 'https',
        host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
        port: kReleaseMode
            ? int.parse(dotenv.env['PROD_PORT'].toString())
            : int.parse(dotenv.env['DEV_PORT'].toString()),
        path: 'api/Users/stats',
      );

      try {
        final response = await Api().dio.get(
              url.toString(),
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );

        if (response.statusCode == 200) {
          result = UserStats.fromJson(response.data);
        }
      } catch (e) {
        // rethrow the caught exception
        rethrow;
      }
    }

    return result;
  }

  Future<List<HistoryModel?>> getHistory(int pageNumber, int pageSize) async {
    late List<HistoryModel?> result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var json = {"pageNumber": '$pageNumber', "pageSize": '$pageSize'};
      String url = '$baseUrl/api/Users/stats/history';

      var response = await Api().dio.get(
            url,
            queryParameters: json,
            options: Options(
              headers: {
                "Accept": "application/json",
                "content-type": "application/json",
              },
            ),
          );

      if (response.statusCode == 200) {
        List<HistoryModel> dta = (response.data as List)
            .map((i) => HistoryModel.fromJson(i))
            .toList();
        result = dta;
      } else {
        result = [];
      }
    }
    return result;
  }
}
