import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/history/historyModel.dart';
import 'package:dano_foosball/models/history/userStats.dart';
import 'package:dano_foosball/utils/helpers.dart';

class HistoryApi {
  HistoryApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<UserStats?> getStats() async {
    UserStats? result;

    String url = '$baseUrl/api/Users/stats';

    try {
      final response = await Api().dio.get(
            url,
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

    return result;
  }

  Future<List<HistoryModel?>> getHistory(int pageNumber, int pageSize) async {
    late List<HistoryModel?> result;

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
      List<HistoryModel> dta =
          (response.data as List).map((i) => HistoryModel.fromJson(i)).toList();
      result = dta;
    } else {
      result = [];
    }

    return result;
  }
}
