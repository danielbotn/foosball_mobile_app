import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/double-league-players/double_league_player_create.dart';
import 'package:foosball_mobile_app/models/double-league-players/double_league_player_create_body.dart';
import 'package:foosball_mobile_app/models/double-league-players/double_league_player_model.dart';

class DoubleLeaguePlayersApi {
  DoubleLeaguePlayersApi();

  Future<List<DoubleLeaguePlayerModel>?> getDoubleLeaguePlayers(
      int leagueId) async {
    late List<DoubleLeaguePlayerModel>? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/DoubleLeaguePlayers/$leagueId';

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
          List<DoubleLeaguePlayerModel> players;
          players = (response.data as List)
              .map((i) => DoubleLeaguePlayerModel.fromJson(i))
              .toList();
          result = players;
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<DoubleLeaguePlayerCreate?> createDoubleLeaguePlayer(
      DoubleLeaguePlayerCreateBody body) async {
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      var url = '$baseUrl/api/DoubleLeaguePlayers';

      var jsonObject = {
        "userOneId": body.userOneId,
        "userTwoId": body.userTwoId,
        "teamId": body.teamId
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

        if (response.statusCode == 200) {
          return DoubleLeaguePlayerCreate.fromJson(response.data);
        } else {
          throw Exception('Failed to create double league player');
        }
      } catch (e) {
        // rethrow the caught exception
        rethrow;
      }
    }
    return null;
  }
}
