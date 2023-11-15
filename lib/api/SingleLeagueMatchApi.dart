import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/single-league-matches/create-single-league-matches-response.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single-league-match-update/single_league_match_update_model.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';

class SingleLeagueMatchApi {
  SingleLeagueMatchApi();

  Future<SingleLeagueMatchModel?> getSingleLeagueMatchById(int id) async {
    late SingleLeagueMatchModel? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/SingleLeagueMatches/$id';

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
          result = SingleLeagueMatchModel.fromJson(response.data);
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }

    return result;
  }

  Future<List<SingleLeagueMatchModel>?> getAllSingleLeagueMatchesByLeagueId(
      int leagueId) async {
    late List<SingleLeagueMatchModel>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/SingleLeagueMatches?leagueId=$leagueId';

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
          List<SingleLeagueMatchModel> data;
          data = (response.data as List)
              .map((i) => SingleLeagueMatchModel.fromJson(i))
              .toList();
          result = data;
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }

    return result;
  }

  Future<bool> updateSingleLeagueMatch(
    int matchId,
    SingleLeagueMatchUpdateModel matchUpdate,
  ) async {
    bool result = false;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/SingleLeagueMatches?matchId=$matchId';

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

      if (matchUpdate.playerOneScore != null) {
        operations.add({
          "op": "replace",
          "path": "/PlayerOneScore",
          "value": matchUpdate.playerOneScore,
        });
      }

      if (matchUpdate.playerTwoScore != null) {
        operations.add({
          "op": "replace",
          "path": "/PlayerTwoScore",
          "value": matchUpdate.playerTwoScore,
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
    }
    return result;
  }

  Future<List<CreateSingleLeagueMatchesResponse>?> createSingleLeagueMatches(
      int leagueId) async {
    late List<CreateSingleLeagueMatchesResponse>? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
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
          List<CreateSingleLeagueMatchesResponse>? leagues;
          leagues = (response.data as List)
              .map((i) => CreateSingleLeagueMatchesResponse.fromJson(i))
              .toList();

          result = leagues;
        } else {
          throw Exception('Failed to create league');
        }
      } catch (e) {
        // rethrow the caught exception
        rethrow;
      }
    }
    return result;
  }
}
