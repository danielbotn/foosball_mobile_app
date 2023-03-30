import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:http/http.dart' as http;

class Organisation {
  Organisation();

  Future<OrganisationResponse?> getOrganisationById(int organisationId) async {
    // PreferencesService preferencesService = PreferencesService();
    // String? token = await preferencesService.getJwtToken();

    late OrganisationResponse organisationResponse;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/Organisations/$organisationId';

      var response = await Api().dio.get(
            url,
            options: Options(
              headers: {
                "Accept": "application/json",
                "content-type": "application/json",
                // 'Authorization': 'Bearer $token',
              },
            ),
          );
      if (response.statusCode == 200) {
        organisationResponse = OrganisationResponse.fromJson(response.data);
        return organisationResponse;
      }
    }

    return null;
  }

  Future<http.Response> getOrganisationByIdTwo(int organisationId) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Organisations/$organisationId');

      result = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
    }
    return result;
  }

  Future<http.Response> getOrganisationsByUser() async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
    late http.Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = Uri.parse('$baseUrl/api/Organisations/user');

      result = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
    }
    return result;
  }

  Future<http.Response> createNewOrganisation(String name) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
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
            'Authorization': 'Bearer $token',
          },
          body: body);
    }
    return result;
  }

  Future<http.Response> joinOrganisation(
      String organisationCodeAndOrganisationId) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
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
            'Authorization': 'Bearer $token',
          },
          body: body);
    }
    return result;
  }

  Future<http.Response> updateUserIsAdmin(
      int organisationId, int userIdToChange, bool isAdmin) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
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
        'Authorization': 'Bearer $token',
      });
    }
    return result;
  }

  Future<http.Response> leaveOrRejoinOrganisation(
      int organisationId, int userId, bool isDeleted) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
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
        'Authorization': 'Bearer $token',
      });
    }
    return result;
  }

  Future<http.Response> changeOrganisation(
      int organisationId, int newOrganisationId, int userId) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
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
        'Authorization': 'Bearer $token',
      });
    }
    return result;
  }
}
