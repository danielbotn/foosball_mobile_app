import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/single-league-players/single_league_players_model.dart';

class SingleLeaguePlayersApi {
  SingleLeaguePlayersApi();

  Future<bool> addSingleLeaguePlayers(
      SingleLeaguePlayersModel singleLeaguePlayersModel) async {
    bool result = false;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/SingleLeaguePlayers';

      try {
        final response = await Api().dio.post(
              url,
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
              data: jsonEncode(singleLeaguePlayersModel),
            );

        if (response.statusCode == 200) {
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
