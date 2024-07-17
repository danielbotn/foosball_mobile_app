import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';
import 'package:foosball_mobile_app/models/double-league-matches/create_double_league_matches_response.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_update_model.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class DoubleLeagueMatchApi {
  DoubleLeagueMatchApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<DoubleLeagueMatchModel?> getDoubleLeagueMatch(int matchId) async {
    late DoubleLeagueMatchModel? result;

    var url = '$baseUrl/api/DoubleLeagueMatches/match/$matchId';

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
        result = DoubleLeagueMatchModel.fromJson(response.data);
      } else {
        result = null;
      }
    } catch (e) {
      rethrow;
    }

    return result;
  }

  Future<List<DoubleLeagueMatchModel>?> getAllDoubleLeagueMatchesByLeagueId(
      int leagueId) async {
    late List<DoubleLeagueMatchModel>? result;

    var url = '$baseUrl/api/DoubleLeagueMatches?leagueId=$leagueId';

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
        List<DoubleLeagueMatchModel> data;
        data = (response.data as List)
            .map((i) => DoubleLeagueMatchModel.fromJson(i))
            .toList();
        result = data;
      } else {
        result = null;
      }
    } catch (e) {
      rethrow;
    }

    return result;
  }

  Future<List<CreateDoubleLeagueMatchesResponse>?> createDoubleLeagueMatches(
      int leagueId) async {
    late List<CreateDoubleLeagueMatchesResponse>? result;

    String url = '$baseUrl/api/DoubleLeagueMatches/create-matches';

    var jsonObject = {
      "leagueId": leagueId,
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
        List<CreateDoubleLeagueMatchesResponse>? leagues;
        leagues = (response.data as List)
            .map((i) => CreateDoubleLeagueMatchesResponse.fromJson(i))
            .toList();

        result = leagues;
      } else {
        throw Exception('Failed to create league');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }

  Future<bool> updateDoubleLeagueMatch(
    int matchId,
    DoubleLeagueMatchUpdateModel matchUpdate,
  ) async {
    bool result = false;

    var url = '$baseUrl/api/DoubleLeagueMatches?matchId=$matchId';

    final List<Map<String, dynamic>> operations = [];

    if (matchUpdate.startTime != null) {
      operations.add({
        "op": "replace",
        "path": "/StartTime",
        "value": matchUpdate.startTime!.toString(),
      });
    }

    if (matchUpdate.endTime != null) {
      operations.add({
        "op": "replace",
        "path": "/EndTime",
        "value": matchUpdate.endTime!.toString(),
      });
    }

    if (matchUpdate.teamOneScore != null) {
      operations.add({
        "op": "replace",
        "path": "/TeamOneScore",
        "value": matchUpdate.teamOneScore,
      });
    }

    if (matchUpdate.teamTwoScore != null) {
      operations.add({
        "op": "replace",
        "path": "/TeamTwoScore",
        "value": matchUpdate.teamTwoScore,
      });
    }

    if (matchUpdate.matchStarted != null) {
      operations.add({
        "op": "replace",
        "path": "/MatchStarted",
        "value": matchUpdate.matchStarted,
      });
    }

    if (matchUpdate.matchEnded != null) {
      operations.add({
        "op": "replace",
        "path": "/MatchEnded",
        "value": matchUpdate.matchEnded,
      });
    }

    if (matchUpdate.matchPaused != null) {
      operations.add({
        "op": "replace",
        "path": "/MatchPaused",
        "value": matchUpdate.matchPaused,
      });
    }

    try {
      final response = await Api().dio.patch(
            url,
            data: operations,
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
