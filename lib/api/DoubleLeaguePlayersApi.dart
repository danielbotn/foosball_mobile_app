import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/double-league-players/double_league_player_create.dart';
import 'package:dano_foosball/models/double-league-players/double_league_player_create_body.dart';
import 'package:dano_foosball/models/double-league-players/double_league_player_model.dart';
import 'package:dano_foosball/utils/helpers.dart';

class DoubleLeaguePlayersApi {
  DoubleLeaguePlayersApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<List<DoubleLeaguePlayerModel>?> getDoubleLeaguePlayers(
      int leagueId) async {
    late List<DoubleLeaguePlayerModel>? result;

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

    return result;
  }

  Future<DoubleLeaguePlayerCreate?> createDoubleLeaguePlayer(
      DoubleLeaguePlayerCreateBody body) async {
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
}
