import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-body.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-response.dart';
import 'package:foosball_mobile_app/models/leagues/double-league-standings-model.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/models/leagues/single-league-standings-model.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class LeagueApi {
  LeagueApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<CreateLeagueResponse?> createLeague(
      CreateLeagueBody createLeagueBody) async {
    String url = '$baseUrl/api/Leagues';

    var jsonObject = {
      "name": createLeagueBody.name,
      "typeOfLeague": '${createLeagueBody.typeOfLeague}',
      "upTo": '${createLeagueBody.upTo}',
      "organisationId": '${createLeagueBody.organisationId}',
      "howManyRounds": '${createLeagueBody.howManyRounds}',
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
        return CreateLeagueResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to create league');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }
  }

  Future<GetLeagueResponse?> getLeagueById(int leagueId) async {
    late GetLeagueResponse? result;

    var url = '$baseUrl/api/Leagues/$leagueId';

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
        result = GetLeagueResponse.fromJson(response.data);
      } else {
        result = null;
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }

  Future<List<GetLeagueResponse>?> getLeaguesByOrganisationId(
      int organisationId) async {
    late List<GetLeagueResponse>? result;

    var url = '$baseUrl/api/Leagues/organisation/$organisationId';

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
        List<GetLeagueResponse>? leagues;
        leagues = (response.data as List)
            .map((i) => GetLeagueResponse.fromJson(i))
            .toList();

        result = leagues;
      } else {
        result = null;
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }

  Future<bool> updateLeague(
    int leagueId,
    CreateLeagueBody leagueUpdate,
  ) async {
    bool result = false;

    var url = '$baseUrl/api/Leagues/$leagueId';

    final List<Map<String, dynamic>> operations = [];

    if (leagueUpdate.hasLeagueStarted != null) {
      operations.add({
        "op": "replace",
        "path": "/HasLeagueStarted",
        "value": leagueUpdate.hasLeagueStarted,
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

  Future<List<SingleLeagueStandingsModel>?> getSingleLeagueStandings(
      int leagueId) async {
    late List<SingleLeagueStandingsModel>? result;

    var url = '$baseUrl/api/Leagues/single-league/standings?leagueId=$leagueId';

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
        List<SingleLeagueStandingsModel>? standings;
        standings = (response.data as List)
            .map((i) => SingleLeagueStandingsModel.fromJson(i))
            .toList();

        result = standings;
      } else {
        result = null;
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }

  Future<List<DoubleLeagueStandingsModel>?> geDoubleLeagueStandings(
      int leagueId) async {
    late List<DoubleLeagueStandingsModel>? result;

    var url = '$baseUrl/api/Leagues/double-league/standings?leagueId=$leagueId';

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
        List<DoubleLeagueStandingsModel>? standings;
        standings = (response.data as List)
            .map((i) => DoubleLeagueStandingsModel.fromJson(i))
            .toList();

        result = standings;
      } else {
        result = null;
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }
}
