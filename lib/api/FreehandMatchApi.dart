import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_body.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_create_response.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class FreehandMatchApi {
  FreehandMatchApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<FreehandMatchModel?> getFreehandMatch(int matchId) async {
    late FreehandMatchModel? result;

    var url = Uri.parse('$baseUrl/api/FreehandMatches/$matchId');
    var response = await Api().dio.get(url.toString(),
        options: Options(
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
        ));
    if (response.statusCode == 200) {
      result = FreehandMatchModel.fromJson(response.data);
    } else {
      // To do Error handling
      result = null;
    }

    return result;
  }

  Future<FreehandMatchCreateResponse?> createNewFreehandMatch(
      FreehandMatchBody freehandMatchBody) async {
    var url = '$baseUrl/api/FreehandMatches';

    var jsonObject = {
      "playerOneId": '${freehandMatchBody.playerOneId}',
      "playerTwoId": '${freehandMatchBody.playerTwoId}',
      "playerOneScore": '${freehandMatchBody.playerOneScore}',
      "playerTwoScore": '${freehandMatchBody.playerTwoScore}',
      "upTo": '${freehandMatchBody.upTo}',
      "gameFinished": '${freehandMatchBody.gameFinished}',
      "gamePaused": '${freehandMatchBody.gamePaused}',
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
        return FreehandMatchCreateResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to create freehand match');
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }
  }

  Future<bool> deleteFreehandMatch(int matchId) async {
    String url = '$baseUrl/api/FreehandMatches/$matchId';

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
