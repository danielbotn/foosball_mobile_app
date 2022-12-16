import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'TokenHelper.dart';

class Organisation {
  final String token;
  Organisation({required this.token});

  Future<http.Response> getOrganisationById(int organisationId) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Organisations/$organisationId');

      result = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
    }
    return result;
  }

  Future<http.Response> getOrganisationsByUser() async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Organisations/user');

      result = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
    }
    return result;
  }

  Future<http.Response> createNewOrganisation(String name) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Organisations');
      var body = jsonEncode({'name': name, 'organisationType': 0});
      result = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': 'Bearer $checkedToken',
          },
          body: body);
    }
    return result;
  }

  Future<http.Response> joinOrganisation(
      String organisationCodeAndOrganisationId) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Organisations/join-organisation');
      var body = jsonEncode({
        'OrganisationCodeAndOrganisationId': organisationCodeAndOrganisationId
      });
      result = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': 'Bearer $checkedToken',
          },
          body: body);
    }
    return result;
  }

  Future<http.Response> updateUserIsAdmin(
      int organisationId, int userIdToChange, bool isAdmin) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(
          '$baseUrl/api/Organisations/update-is-admin?organisationId=$organisationId&userIdToChange=$userIdToChange&isAdmin=$isAdmin');

      result = await http.put(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
    }
    return result;
  }

  Future<http.Response> leaveOrRejoinOrganisation(
      int organisationId, int userId, bool isDeleted) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(
          '$baseUrl/api/Organisations/leave-or-rejoin-organisation?organisationId=$organisationId&userId=$userId&isDeleted=$isDeleted');

      result = await http.put(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
    }
    return result;
  }

  Future<http.Response> changeOrganisation(
      int organisationId, int newOrganisationId, int userId) async {
    TokenHelper tokenHelper = TokenHelper();
    String checkedToken = await tokenHelper.checkTokenExpiry(token);
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse(
          '$baseUrl/api/Organisations/change-current-organisation?userId=$userId&currentOrganisationId=$organisationId&newOrganisationId=$newOrganisationId');

      result = await http.put(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $checkedToken',
      });
    }
    return result;
  }
}
