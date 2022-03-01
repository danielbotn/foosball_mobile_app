import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      var url = Uri.parse(baseUrl + '/api/FreehandDoubleMatches/' + matchId.toString());
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
}
