import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/TokenHelper.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-body.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-response.dart';
import 'package:http/http.dart' as http;

class LeagueApi {
  final String token;

  LeagueApi({required this.token});

  Future<CreateLeagueResponse?> createLeague(
      CreateLeagueBody createLeagueBody) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
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
        path: 'api/Leagues',
      );

      var jsonObject = {
        "name": createLeagueBody.name,
        "typeOfLeague": '${createLeagueBody.typeOfLeague}',
        "upTo": '${createLeagueBody.upTo}',
        "organisationId": '${createLeagueBody.organisationId}',
        "howManyRounds": '${createLeagueBody.howManyRounds}',
      };

      var response = await http.post(
        outgoingUri,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $checkedToken',
        },
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 201) {
        return CreateLeagueResponse.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    }
    return null;
  }
}
