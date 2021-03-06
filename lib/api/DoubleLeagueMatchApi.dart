import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';
import 'package:http/http.dart' as http;

class DoubleLeagueMatchApi {
  final String token;

  DoubleLeagueMatchApi({required this.token});

  Future<DoubleLeagueMatchModel?> getDoubleLeagueMatch(int matchId) async {
    late DoubleLeagueMatchModel? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(baseUrl + '/api/DoubleLeagueMatches/' + matchId.toString());
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        result = DoubleLeagueMatchModel.fromJson(jsonDecode(response.body));
      } else {
        // To do Error handling
        result = null;
      }
    }
    return result;
  }
}
