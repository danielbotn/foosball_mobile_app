import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/user/create_group_user_model.dart';
import 'package:foosball_mobile_app/models/user/user_last_ten.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:http/http.dart' as http;

import 'TokenHelper.dart';

class UserApi {
  final String token;

  UserApi({required this.token});

  Future<UserResponse> getUser(String userId) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiryTwo();
    late UserResponse result = UserResponse(
      id: 0,
      email: '',
      firstName: '',
      lastName: '',
      createdAt: DateTime.now(),
      currentOrganisationId: null,
      photoUrl: '',
      isAdmin: null,
      isDeleted: false,
    );
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Users/$userId');
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
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
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiryTwo();
    late UserStatsResponse result = UserStatsResponse(
        userId: 0,
        totalMatches: 0,
        totalMatchesWon: 0,
        totalMatchesLost: 0,
        totalGoalsScored: 0,
        totalGoalsReceived: 0);
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Users/stats');
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });

      if (response.statusCode == 200) {
        var dta = UserStatsResponse.fromJson(jsonDecode(response.body));
        result = UserStatsResponse(
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

  Future<List<UserLastTen>?> getLastTenMatches() async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiryTwo();
    late List<UserLastTen>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Users/stats/last-ten-matches');

      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });

      if (response.statusCode == 200) {
        List<UserLastTen> userLastTen;
        userLastTen = (json.decode(response.body) as List)
            .map((i) => UserLastTen.fromJson(i))
            .toList();

        result = userLastTen;
      } else {
        result = null;
      }
    }
    return result;
  }

  Future<List<UserResponse>?> getUsers() async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiryTwo();
    late List<UserResponse>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Users');

      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });

      if (response.statusCode == 200) {
        List<UserResponse> userLastTen;
        userLastTen = (json.decode(response.body) as List)
            .map((i) => UserResponse.fromJson(i))
            .toList();

        result = userLastTen;
      } else {
        result = null;
      }
    }
    return result;
  }

  Future<http.Response> createGroupUser(CreateGroupUserModel data) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiryTwo();
    late http.Response result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Users/group-user');
      var body = jsonEncode({
        'firstName': data.firstName,
        'lastName': data.lastName,
      });

      result = await http.post(url, body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
    }
    return result;
  }
}
