import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/dio_api/dio_api.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';

class Organisation {
  Organisation();

  Future<OrganisationResponse?> getOrganisationById(int organisationId) async {
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

  Future<List<OrganisationResponse>?> getOrganisationsByUser() async {
    List<OrganisationResponse>? result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
      var url = '$baseUrl/api/Organisations/user';

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
          List<OrganisationResponse>? organisations;
          organisations = (response.data as List)
              .map((i) => OrganisationResponse.fromJson(i))
              .toList();

          result = organisations;
        } else {
          result = null;
        }
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<Response> createNewOrganisation(String name) async {
    late Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      try {
        var response = await Api().dio.post(
              '$baseUrl/api/Organisations',
              data: {'name': name, 'organisationType': 0},
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        result = response;
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<Response> joinOrganisation(
      String organisationCodeAndOrganisationId) async {
    late Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      try {
        var response = await Api().dio.post(
              '$baseUrl/api/Organisations/join-organisation',
              data: {
                'OrganisationCodeAndOrganisationId':
                    organisationCodeAndOrganisationId
              },
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        result = response;
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<Response> updateUserIsAdmin(
      int organisationId, int userIdToChange, bool isAdmin) async {
    late Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      try {
        var response = await Api().dio.put(
              '$baseUrl/api/Organisations/update-is-admin',
              queryParameters: {
                'organisationId': organisationId,
                'userIdToChange': userIdToChange,
                'isAdmin': isAdmin
              },
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        result = response;
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<Response> leaveOrRejoinOrganisation(
      int organisationId, int userId, bool isDeleted) async {
    late Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      try {
        var response = await Api().dio.put(
              '$baseUrl/api/Organisations/leave-or-rejoin-organisation',
              queryParameters: {
                'organisationId': organisationId,
                'userId': userId,
                'isDeleted': isDeleted
              },
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        result = response;
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }

  Future<Response> changeOrganisation(
      int organisationId, int newOrganisationId, int userId) async {
    late Response result;

    String? baseUrl = kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'];

    if (baseUrl != null) {
      try {
        var response = await Api().dio.put(
              '$baseUrl/api/Organisations/change-current-organisation',
              queryParameters: {
                'userId': userId,
                'currentOrganisationId': organisationId,
                'newOrganisationId': newOrganisationId
              },
              options: Options(
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
              ),
            );
        result = response;
      } catch (e) {
        rethrow;
      }
    }
    return result;
  }
}
