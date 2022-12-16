import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goal_body.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goal_model.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:http/http.dart' as http;

import 'TokenHelper.dart';

class FreehandGoalsApi {
  final String token;

  FreehandGoalsApi({required this.token});

  Future<FreehandGoalModel?> createFreehandGoal(
      FreehandGoalBody freehandGoalBody) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
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
        path: 'api/FreehandGoals',
      );

      var jsonObject = {
        "matchId": '${freehandGoalBody.matchId}',
        "scoredByUserId": '${freehandGoalBody.scoredByUserId}',
        "oponentId": '${freehandGoalBody.oponentId}',
        "scoredByScore": '${freehandGoalBody.scoredByScore}',
        "oponentScore": '${freehandGoalBody.oponentScore}',
        "winnerGoal": '${freehandGoalBody.winnerGoal}',
      };

      var response = await http.post(
        outgoingUri,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $checkedToken',
        },
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 201) {
        return FreehandGoalModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create freehand goal');
      }
    }
    return null;
  }

  Future<List<FreehandGoalsModel>?> getFreehandGoals(int matchId) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late List<FreehandGoalsModel>? result;

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
        path: 'api/FreehandGoals/goals/$matchId',
      );

      var response = await http.get(outgoingUri, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });

      if (response.statusCode == 200) {
        List<FreehandGoalsModel>? freehandGoals;
        freehandGoals = (json.decode(response.body) as List)
            .map((i) => FreehandGoalsModel.fromJson(i))
            .toList();

        result = freehandGoals;
      } else {
        result = null;
      }
    }
    return result;
  }

  Future<bool> deleteFreehandGoal(int goalId, int matchId) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    bool result = false;
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
        path: 'api/FreehandGoals/$matchId/$goalId',
      );
      var url = outgoingUri;
      var response = await http.delete(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $checkedToken',
        },
      );

      if (response.statusCode == 204) {
        result = true;
      } else {
        result = false;
      }
    }
    return result;
  }
}
