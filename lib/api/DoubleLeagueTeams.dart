import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/double-league-teams/createDoubleLeagueTeamBody.dart';
import 'package:foosball_mobile_app/models/double-league-teams/create_double_league_team_return.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class DoubleLeagueTeamsApi {
  DoubleLeagueTeamsApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<CreateDoubleLeagueTeamReturn?> createDoubleLeagueTeam(
      CreateDoubleLeagueTeamBody body) async {
    var url = '$baseUrl/api/DoubleLeagueTeams';

    var jsonObject = {
      "leagueId": body.leagueId,
      "name": body.name,
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
        return CreateDoubleLeagueTeamReturn.fromJson(response.data);
      } else {
        throw Exception('Failed to create freehand goal');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }
  }
}
