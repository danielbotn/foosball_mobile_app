import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single_league_goal_model.dart';

class SingleLeagueGoalApi {
  SingleLeagueGoalApi();

  Future<List<SingleLeagueGoalModel>?> getSingleLeagueGoals(
      int leagueId, int matchId) async {
    late List<SingleLeagueGoalModel>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
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
    }
    return result;
  }
}
