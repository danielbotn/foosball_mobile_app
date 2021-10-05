import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:http/http.dart' as http;

class User {
  final String token;

  User({required this.token});

  Future<UserResponse> getUser(String userId) async {
    late UserResponse result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/Users/' + userId);
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        result = UserResponse.fromJson(jsonDecode(response.body));
      } else {
        // To do Error handling
      }
    }
    return result;
  }

  Future<UserStatsResponse> getUserStats() async {
    late UserStatsResponse result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/Users/stats');
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var dta = UserStatsResponse.fromJson(jsonDecode(response.body));
        result = new UserStatsResponse(
            totalGoalsReceived: dta.totalGoalsReceived,
            totalGoalsScored: dta.totalGoalsScored,
            totalMatches: dta.totalMatches,
            totalMatchesLost: dta.totalMatchesLost,
            totalMatchesWon: dta.totalMatchesWon,
            userId: dta.userId);
      } else {
        // To do Error handling
      }
    }
    return result;
  }
}
