import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      var url = Uri.parse(baseUrl + '/api/FreehandMatches/' + matchId.toString());
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
        result = FreehandMatchModel.fromJson(jsonDecode(response.body));
      } else {
        print('Failure: ${response.body}');
        // To do Error handling
        result = null;
      }
    }
    return result;
  }
}
