import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/leagues/create-league-body.dart';
import 'package:dano_foosball/models/leagues/create-league-response.dart';
import 'package:dano_foosball/models/leagues/double-league-standings-model.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/models/leagues/single-league-standings-model.dart';
import 'package:dano_foosball/utils/helpers.dart';

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

  Future<bool> updateLeagueName(
    int leagueId,
    String leagueName,
  ) async {
    bool result = false;

    var url = '$baseUrl/api/Leagues/$leagueId';

    // Create a list with a single operation to update the name
    final List<Map<String, dynamic>> operations = [
      {
        "op": "replace",
        "path": "/Name",
        "value": leagueName,
      }
    ];

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
        result = true; // Successfully updated
      } else {
        result = false; // Handle non-success status
      }
    } catch (e) {
      rethrow; // Propagate the error for handling elsewhere
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

  Future<bool> deleteLeagueById(int leagueId) async {
    String url = '$baseUrl/api/Leagues/$leagueId';

    try {
      final response = await Api().dio.delete(
            url,
            options: Options(
              headers: {
                "Accept": "application/json",
                "content-type": "application/json",
              },
            ),
          );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete freehand match');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }
  }
}
