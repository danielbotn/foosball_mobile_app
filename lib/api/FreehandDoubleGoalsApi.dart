import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_body.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_model.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_return.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:http/http.dart' as http;

class FreehandDoubleGoalsApi {
  FreehandDoubleGoalsApi();

  Future<List<FreehandDoubleGoalModel>?> getFreehandDoubleGoals(
      int matchId) async {
    late List<FreehandDoubleGoalModel>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/FreehandDoubleGoals/goals/$matchId';

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
          List<FreehandDoubleGoalModel> userLastTen;
          userLastTen = (response.data as List)
              .map((i) => FreehandDoubleGoalModel.fromJson(i))
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

  Future<FreehandDoubleGoalReturn?> createDoubleFreehandGoal(
      FreehandDoubleGoalBody freehandGoalBody) async {
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      var url = '$baseUrl/api/FreehandDoubleGoals';

      var jsonObject = {
        "doubleMatchId": '${freehandGoalBody.doubleMatchId}',
        "scoredByUserId": '${freehandGoalBody.scoredByUserId}',
        "scorerTeamScore": '${freehandGoalBody.scorerTeamScore}',
        "opponentTeamScore": '${freehandGoalBody.opponentTeamScore}',
        "winnerGoal": '${freehandGoalBody.winnerGoal}',
      };

      try {
        final response = await Api().dio.post(
              url,
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
              data: jsonEncode(jsonObject),
            );

        if (response.statusCode == 201) {
          return FreehandDoubleGoalReturn.fromJson(response.data);
        } else {
          throw Exception('Failed to create freehand goal');
        }
      } catch (e) {
        // rethrow the caught exception
        rethrow;
      }
    }
    return null;
  }

  // Delete a goal
  Future<bool> deleteFreehandDoubleGoal(int goalId, int matchId) async {
    bool result = false;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/FreehandDoubleGoals/$matchId/$goalId';
      try {
        final response = await Api().dio.delete(
              url,
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        if (response.statusCode == 204) {
          result = true;
        }
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }
}
