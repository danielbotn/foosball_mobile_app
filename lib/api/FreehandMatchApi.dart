import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_body.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_create_response.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:http/http.dart' as http;

class FreehandMatchApi {
  FreehandMatchApi();

  Future<FreehandMatchModel?> getFreehandMatch(int matchId) async {
    late FreehandMatchModel? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
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
    }
    return result;
  }

  Future<FreehandMatchCreateResponse?> createNewFreehandMatch(
      FreehandMatchBody freehandMatchBody) async {
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
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
    return null;
  }

  Future<bool> deleteFreehandMatch(int matchId) async {
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
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
    return false;
  }
}
