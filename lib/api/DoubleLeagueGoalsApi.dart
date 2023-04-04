import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
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
        final response = await Api().dio.post(
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
}
