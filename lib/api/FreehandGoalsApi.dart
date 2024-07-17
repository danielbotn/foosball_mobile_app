import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goal_body.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goal_model.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class FreehandGoalsApi {
  FreehandGoalsApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<FreehandGoalModel?> createFreehandGoal(
      FreehandGoalBody freehandGoalBody) async {
    var url = '$baseUrl/api/FreehandGoals';

    var jsonObject = {
      "matchId": '${freehandGoalBody.matchId}',
      "scoredByUserId": '${freehandGoalBody.scoredByUserId}',
      "oponentId": '${freehandGoalBody.oponentId}',
      "scoredByScore": '${freehandGoalBody.scoredByScore}',
      "oponentScore": '${freehandGoalBody.oponentScore}',
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
        return FreehandGoalModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create freehand goal');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }
  }

  Future<List<FreehandGoalsModel>?> getFreehandGoals(int matchId) async {
    late List<FreehandGoalsModel>? result;

    var url = '$baseUrl/api/FreehandGoals/goals/$matchId';

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
        List<FreehandGoalsModel>? freehandGoals;
        freehandGoals = (response.data as List)
            .map((i) => FreehandGoalsModel.fromJson(i))
            .toList();

        result = freehandGoals;
      } else {
        result = null;
      }
    } catch (e) {
      rethrow;
    }

    return result;
  }

  Future<bool> deleteFreehandGoal(int goalId, int matchId) async {
    bool result = false;

    try {
      final dio = Api().dio;
      final response = await dio.delete(
        'api/FreehandGoals/$matchId/$goalId',
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

    return result;
  }
}
