import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';

class SingleLeagueMatchApi {
  SingleLeagueMatchApi();

  Future<SingleLeagueMatchModel?> getSingleLeagueMatchById(int id) async {
    late SingleLeagueMatchModel? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/SingleLeagueMatches/$id';

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
          result = SingleLeagueMatchModel.fromJson(response.data);
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }

    return result;
  }

  Future<List<SingleLeagueMatchModel>?> getAllSingleLeagueMatchesByLeagueId(
      int leagueId) async {
    late List<SingleLeagueMatchModel>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/SingleLeagueMatches?leagueId=$leagueId';

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
          List<SingleLeagueMatchModel> data;
          data = (response.data as List)
              .map((i) => SingleLeagueMatchModel.fromJson(i))
              .toList();
          result = data;
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
