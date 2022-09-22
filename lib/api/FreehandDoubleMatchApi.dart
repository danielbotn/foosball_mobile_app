import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_create_response.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:http/http.dart' as http;

class FreehandDoubleMatchApi {
  final String token;

  FreehandDoubleMatchApi({required this.token});

  Future<FreehandDoubleMatchModel?> getDoubleFreehandMatch(int matchId) async {
    late FreehandDoubleMatchModel? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/FreehandDoubleMatches/$matchId');
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        result = FreehandDoubleMatchModel.fromJson(jsonDecode(response.body));
      } else {
        // To do Error handling
        result = null;
      }
    }
    return result;
  }

  Future<FreehandDoubleMatchCreateResponse?> createNewDoubleFreehandMatch(
      FreehandDoubleMatchBody freehandMatchBody) async {
    late FreehandDoubleMatchCreateResponse? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
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
      Uri outgoingUri = Uri(
          scheme: 'https',
          host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
          port: kReleaseMode
              ? int.parse(dotenv.env['PROD_PORT'].toString())
              : int.parse(dotenv.env['DEV_PORT'].toString()),
          path: 'api/FreehandDoubleMatches');
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
        result = FreehandDoubleMatchCreateResponse.fromJson(
            jsonDecode(response.body));
      } else {
        // To do Error handling
        result = null;
      }
    }
    return result;
  }

  Future<bool> deleteDoubleFreehandMatch(int matchId) async {
    bool result = false;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      Uri outgoingUri = Uri(
          scheme: 'https',
          host: kReleaseMode ? dotenv.env['PROD_HOST'] : dotenv.env['DEV_HOST'],
          port: kReleaseMode
              ? int.parse(dotenv.env['PROD_PORT'].toString())
              : int.parse(dotenv.env['DEV_PORT'].toString()),
          path: 'api/FreehandDoubleMatches/$matchId');
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
        result = true;
      } else {
        // To do Error handling
        result = false;
      }
    }
    return result;
  }
}
