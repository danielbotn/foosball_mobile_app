import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_body.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_create_response.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:http/http.dart' as http;

class FreehandMatchApi {
  final String token;

  FreehandMatchApi({required this.token});

  Future<FreehandMatchModel?> getFreehandMatch(int matchId) async {
    late FreehandMatchModel? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url =
          Uri.parse(baseUrl + '/api/FreehandMatches/' + matchId.toString());
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        result = FreehandMatchModel.fromJson(jsonDecode(response.body));
      } else {
        // To do Error handling
        result = null;
      }
    }
    return result;
  }

  Future<FreehandMatchCreateResponse?> createNewFreehandMatch(
      FreehandMatchBody freehandMatchBody) async {
    late FreehandMatchCreateResponse? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var jsonObject = {
        "playerOneId": '${freehandMatchBody.playerOneId}',
        "playerTwoId": '${freehandMatchBody.playerTwoId}',
        "playerOneScore": '${freehandMatchBody.playerOneScore}',
        "playerTwoScore": '${freehandMatchBody.playerTwoScore}',
        "upTo": '${freehandMatchBody.upTo}',
        "gameFinished": '${freehandMatchBody.gameFinished}',
        "gamePaused": '${freehandMatchBody.gamePaused}',
      };
      Uri outgoingUri = new Uri(
          scheme: 'https',
          host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
          port: kReleaseMode
              ? int.parse(dotenv.env['PROD_PORT'].toString())
              : int.parse(dotenv.env['DEV_PORT'].toString()),
          path: 'api/FreehandMatches');
      var url = outgoingUri;
      var response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 201) {
        result =
            FreehandMatchCreateResponse.fromJson(jsonDecode(response.body));
      } else {
        // To do Error handling
        result = null;
      }
    }
    return result;
  }

   Future<bool> deleteFreehandMatch(int matchId) async {
    bool success = false;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      Uri outgoingUri = new Uri(
          scheme: 'https',
          host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
          port: kReleaseMode
              ? int.parse(dotenv.env['PROD_PORT'].toString())
              : int.parse(dotenv.env['DEV_PORT'].toString()),
          path: 'api/FreehandMatches/' + matchId.toString());
      var url = outgoingUri;
      var response = await http.delete(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        success = true;
      } else {
        // To do Error handling
        success = false;
      }
    }
    return success;
  }

}
