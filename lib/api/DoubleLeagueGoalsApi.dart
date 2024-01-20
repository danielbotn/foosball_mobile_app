import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double-league-goal-body.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double_league_goal_create_response.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double_league_goal_model.dart';

class DoubleLeagueGoalsApi {
  Future<List<DoubleLeagueGoalModel>?> getDoubleLeagueGoals(int matchId) async {
    late List<DoubleLeagueGoalModel>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/DoubleLeagueGoals/match/$matchId';
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
          List<DoubleLeagueGoalModel> userLastTen;
          userLastTen = (response.data as List)
              .map((i) => DoubleLeagueGoalModel.fromJson(i))
              .toList();

          result = userLastTen;
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<DoubleLeagueGoalCreateResponse?> createDoubleLeagueGoal(
      DoubleLeagueGoalBody body) async {
    DoubleLeagueGoalCreateResponse? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/DoubleLeagueGoals';

      var jsonObject = {
        "timeOfGoal": '${body.timeOfGoal}',
        "matchId": '${body.matchId}',
        "scoredByTeamId": '${body.scoredByTeamId}',
        "opponentTeamId": '${body.opponentTeamId}',
        "scorerTeamScore": '${body.scorerTeamScore}',
        "opponentTeamScore": '${body.opponentTeamScore}',
        "winnerGoal": '${body.winnerGoal}',
        "userScorerId": '${body.userScorerId}',
      };

      final response = await Api().dio.post(
            url,
            data: jsonEncode(jsonObject),
            options: Options(
              headers: {
                "Accept": "application/json",
                "content-type": "application/json",
              },
            ),
          );

      if (response.statusCode == 201) {
        result = DoubleLeagueGoalCreateResponse.fromJson(response.data);
      } else {
        result = null;
      }
    }
    return result;
  }

  Future<bool> deleteDoubleLeagueGoal(int goalId) async {
    bool result = false;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      try {
        final dio = Api().dio;
        final response = await dio.delete(
          '$baseUrl/api/DoubleLeagueGoals/$goalId',
          options: Options(
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
          ),
        );

        if (response.statusCode == 204) {
          result = true;
        } else {
          result = false;
        }
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }
}
