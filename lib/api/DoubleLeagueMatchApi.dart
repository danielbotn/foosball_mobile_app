import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';

class DoubleLeagueMatchApi {
  DoubleLeagueMatchApi();

  Future<DoubleLeagueMatchModel?> getDoubleLeagueMatch(int matchId) async {
    late DoubleLeagueMatchModel? result;
    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/DoubleLeagueMatches/$matchId';

      try {
        final response = await Api().dio.post(
              url,
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );

        if (response.statusCode == 200) {
          result = DoubleLeagueMatchModel.fromJson(response.data);
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }
}
