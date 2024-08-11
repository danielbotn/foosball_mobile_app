import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_create_response.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:dano_foosball/utils/helpers.dart';

class FreehandDoubleMatchApi {
  FreehandDoubleMatchApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<FreehandDoubleMatchModel?> getDoubleFreehandMatch(int matchId) async {
    late FreehandDoubleMatchModel? result;

    var url = '$baseUrl/api/FreehandDoubleMatches/$matchId';

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
      result = FreehandDoubleMatchModel.fromJson(response.data);
    } else {
      // To do Error handling
      result = null;
    }

    return result;
  }

  Future<FreehandDoubleMatchCreateResponse?> createNewDoubleFreehandMatch(
      FreehandDoubleMatchBody freehandMatchBody) async {
    late FreehandDoubleMatchCreateResponse? result;

    var url = '$baseUrl/api/FreehandDoubleMatches';

    var jsonObject = {
      "playerOneTeamA": '${freehandMatchBody.playerOneTeamA}',
      "playerTwoTeamA": '${freehandMatchBody.playerTwoTeamA}',
      "playerOneTeamB": '${freehandMatchBody.playerOneTeamB}',
      "playerTwoTeamB": '${freehandMatchBody.playerTwoTeamB}',
      "organisationId": '${freehandMatchBody.organisationId}',
      "teamAScore": '${freehandMatchBody.teamAScore}',
      "teamBScore": '${freehandMatchBody.teamBScore}',
      "nicknameTeamA": '${freehandMatchBody.nicknameTeamA}',
      "nicknameTeamB": '${freehandMatchBody.nicknameTeamB}',
      "upTo": '${freehandMatchBody.upTo}',
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
        result = FreehandDoubleMatchCreateResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to create freehand match');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }

  Future<bool> deleteDoubleFreehandMatch(int matchId) async {
    bool result = false;

    var url = '$baseUrl/api/FreehandDoubleMatches/$matchId';
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
        result = true;
      } else {
        // To do Error handling
        result = false;
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }
}
