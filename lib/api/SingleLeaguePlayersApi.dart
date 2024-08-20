import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/single-league-players/single_league_players_model.dart';
import 'package:dano_foosball/utils/helpers.dart';

class SingleLeaguePlayersApi {
  SingleLeaguePlayersApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<bool> addSingleLeaguePlayers(
      SingleLeaguePlayersModel singleLeaguePlayersModel) async {
    bool result = false;

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

    return result;
  }
}
