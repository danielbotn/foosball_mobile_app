import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:http/http.dart' as http;

class SingleLeagueMatchApi {
  final String token;

  SingleLeagueMatchApi({required this.token});

  Future<SingleLeagueMatchModel?> getSingleLeagueMatchById(int id) async {
    late SingleLeagueMatchModel? result;

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
          path: 'api/SingleLeagueMatches/' + id.toString(),
          );


      var response = await http.get(outgoingUri, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        result = SingleLeagueMatchModel.fromJson(jsonDecode(response.body));
      } else {
        result = null;
      }
    }
    return result;
  }
}
