import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dano_foosball/api/dio_api/dio_api.dart';
import 'package:dano_foosball/models/charts/user_stats_response.dart';
import 'package:dano_foosball/models/user/create_group_user_model.dart';
import 'package:dano_foosball/models/user/user_last_ten.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/utils/helpers.dart';

class UserApi {
  UserApi();
  Helpers helpers = Helpers();
  String baseUrl =
      kReleaseMode ? Helpers().getProdUrl() : Helpers().getDevUrl();

  Future<UserResponse> getUser(String userId) async {
    late UserResponse result = UserResponse(
      id: 0,
      email: '',
      firstName: '',
      lastName: '',
      createdAt: DateTime.now(),
      currentOrganisationId: null,
      photoUrl: '',
      isAdmin: null,
      isDeleted: false,
    );

    var url = '$baseUrl/api/Users/$userId';
    try {
      final response = await Api().dio.get(url,
          options: Options(headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          }));
      if (response.statusCode == 200) {
        result = UserResponse.fromJson(response.data);
      } else {
        // To do Error handling
      }
    } catch (e) {
      // To do Error handling
    }

    return result;
  }

  Future<UserStatsResponse> getUserStats() async {
    late UserStatsResponse result = UserStatsResponse(
        userId: 0,
        totalMatches: 0,
        totalMatchesWon: 0,
        totalMatchesLost: 0,
        totalGoalsScored: 0,
        totalGoalsReceived: 0);

    var url = '$baseUrl/api/Users/stats';
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
      UserStatsResponse dta = UserStatsResponse.fromJson(response.data);
      result = UserStatsResponse(
          totalGoalsReceived: dta.totalGoalsReceived,
          totalGoalsScored: dta.totalGoalsScored,
          totalMatches: dta.totalMatches,
          totalMatchesLost: dta.totalMatchesLost,
          totalMatchesWon: dta.totalMatchesWon,
          userId: dta.userId);
    } else {
      // To do Error handling
    }

    return result;
  }

  Future<List<UserLastTen>?> getLastTenMatches() async {
    List<UserLastTen>? result;

    var url = '$baseUrl/api/Users/stats/last-ten-matches';

    try {
      var response = await Api().dio.get(url,
          options: Options(headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          }));

      if (response.statusCode == 200) {
        List<UserLastTen> userLastTen;
        userLastTen = (response.data as List)
            .map((i) => UserLastTen.fromJson(i))
            .toList();

        result = userLastTen;
      }
    } catch (e) {
      rethrow;
    }

    return result;
  }

  Future<List<UserResponse>?> getUsers() async {
    late List<UserResponse>? result;

    var url = '$baseUrl/api/Users';

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
      List<UserResponse> userLastTen;
      userLastTen =
          (response.data as List).map((i) => UserResponse.fromJson(i)).toList();

      result = userLastTen;
    } else {
      result = null;
    }

    return result;
  }

  Future<UserResponse?> createGroupUser(CreateGroupUserModel data) async {
    UserResponse? result;

    var url = '$baseUrl/api/Users/group-user';

    try {
      var response = await Api().dio.post(
            url,
            data: {
              'firstName': data.firstName,
              'lastName': data.lastName,
            },
            options: Options(headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            }),
          );

      if (response.statusCode == 200) {
        result = UserResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        rethrow;
      }
    }

    return result;
  }
}
