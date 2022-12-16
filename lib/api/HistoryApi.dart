import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/history/historyModel.dart';
import 'package:foosball_mobile_app/models/history/userStats.dart';
import 'package:http/http.dart' as http;

import 'TokenHelper.dart';

class HistoryApi {
  final String token;
  HistoryApi({required this.token});

  Future<UserStats?> getStats() async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late UserStats? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      Uri outgoingUri = Uri(
        scheme: 'https',
        host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
        port: kReleaseMode
            ? int.parse(dotenv.env['PROD_PORT'].toString())
            : int.parse(dotenv.env['DEV_PORT'].toString()),
        path: 'api/Users/stats',
      );

      var url = outgoingUri;
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
      if (response.statusCode == 200) {
        var dta = UserStats.fromJson(jsonDecode(response.body));
        result = dta;
      } else {
        result = null;
      }
    }
    return result;
  }

  Future<List<HistoryModel?>> getHistory(int pageNumber, int pageSize) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late List<HistoryModel?> result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var json = {"pageNumber": '$pageNumber', "pageSize": '$pageSize'};
      Uri outgoingUri = Uri(
          scheme: 'https',
          host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
          port: kReleaseMode
              ? int.parse(dotenv.env['PROD_PORT'].toString())
              : int.parse(dotenv.env['DEV_PORT'].toString()),
          path: 'api/Users/stats/history',
          queryParameters: json);

      var url = outgoingUri;
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
      if (response.statusCode == 200) {
        List<HistoryModel> dta = (jsonDecode(response.body) as List)
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
