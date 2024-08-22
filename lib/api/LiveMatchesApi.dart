import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/models/live-matches/match.dart';

class LiveMatchesApi {
  LiveMatchesApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<List<Match>?> getLiveMatches() async {
    late List<Match>? result;

    String url = '$baseUrl/api/Matches/live-matches';

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
        List<Match>? matches;
        matches =
            (response.data as List).map((i) => Match.fromJson(i)).toList();

        result = matches;
      } else {
        result = null;
      }
    } catch (e) {
      // rethrow the caught exception
      rethrow;
    }

    return result;
  }
}
