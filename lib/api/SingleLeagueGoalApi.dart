import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single-league-goal-body/single_league_goal_body.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single-league-goal-create-response/single_league_goal_create_response.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single_league_goal_model.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class SingleLeagueGoalApi {
  SingleLeagueGoalApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<List<SingleLeagueGoalModel>?> getSingleLeagueGoals(
      int leagueId, int matchId) async {
    late List<SingleLeagueGoalModel>? result;

    var url = '$baseUrl/api/SingleLeagueGoals/';
    var jsonObject = {"leagueId": '$leagueId', "matchId": '$matchId'};

    final response = await Api().dio.get(url,
        queryParameters: jsonObject,
        options: Options(headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        }));

    if (response.statusCode == 200) {
      List<SingleLeagueGoalModel> userLastTen;
      userLastTen = (response.data as List)
          .map((i) => SingleLeagueGoalModel.fromJson(i))
          .toList();

      result = userLastTen;
    } else {
      result = null;
    }

    return result;
  }

  Future<SingleLeagueGoalCreateResponse?> createSingleLeagueGoal(
      SingleLeagueGoalBody singleLeagueGoalBody) async {
    SingleLeagueGoalCreateResponse? result;

    var url = '$baseUrl/api/SingleLeagueGoals';

    var jsonObject = {
      "matchId": '${singleLeagueGoalBody.matchId}',
      "scoredByUserId": '${singleLeagueGoalBody.scoredByUserId}',
      "opponentId": '${singleLeagueGoalBody.opponentId}',
      "scorerScore": '${singleLeagueGoalBody.scorerScore}',
      "opponentScore": '${singleLeagueGoalBody.opponentScore}',
      "winnerGoal": '${singleLeagueGoalBody.winnerGoal}',
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
      result = SingleLeagueGoalCreateResponse.fromJson(response.data);
    } else {
      result = null;
    }

    return result;
  }

  Future<bool> deleteSingleLeagueGoal(int goalId) async {
    bool result = false;

    try {
      final dio = Api().dio;
      final response = await dio.delete(
        '$baseUrl/api/SingleLeagueGoals/$goalId',
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
