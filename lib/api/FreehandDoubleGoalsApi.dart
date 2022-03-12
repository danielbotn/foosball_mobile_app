import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_model.dart';
import 'package:http/http.dart' as http;

class FreehandDoubleGoalsApi {
  final String token;

  FreehandDoubleGoalsApi({required this.token});

  Future<List<FreehandDoubleGoalModel>?> getFreehandDoubleGoals(int matchId) async {
    late List<FreehandDoubleGoalModel>? result;

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
          path: 'api/FreehandDoubleGoals/goals/' + matchId.toString(),
          );


      var response = await http.get(outgoingUri, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        List<FreehandDoubleGoalModel> userLastTen;
        userLastTen = (json.decode(response.body) as List)
            .map((i) => FreehandDoubleGoalModel.fromJson(i))
            .toList();

        result = userLastTen;
      } else {
        result = null;
      }
    }
    return result;
  }
}
