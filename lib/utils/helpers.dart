import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/AuthApi.dart';
import 'package:dano_foosball/models/auth/login_response.dart';
import 'package:dano_foosball/models/auth/refresh_model.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:dano_foosball/models/other/freehandDoubleMatchObject.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/utils/preferences_service.dart';
import 'app_color.dart';
import 'package:dano_foosball/main.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class Helpers {
  IconThemeData getIconTheme(bool darkMode) {
    if (darkMode == true) {
      return const IconThemeData(color: AppColors.white);
    } else {
      return IconThemeData(color: Colors.grey[700]);
    }
  }

  String getProdUrl() {
    if (kIsWeb) {
      return 'https://prod.api.example.com';
    } else if (Platform.isAndroid || Platform.isIOS) {
      return 'https://mobile-prod.api.example.com';
    } else {
      return 'https://desktop-prod.api.example.com';
    }
  }

  String getDevUrl() {
    if (kIsWeb) {
      return 'https://localhost:7145';
    } else if (Platform.isAndroid) {
      return 'https://10.0.2.2:7145';
    } else if (Platform.isIOS) {
      return 'https://localhost:7145'; // Use 'localhost' for iOS Simulator
    } else {
      return 'https://localhost:7145';
    }
  }

  Color getBackgroundColor(bool darkMode) {
    if (darkMode == true) {
      return AppColors.darkModeBackground;
    } else {
      return AppColors.lightThemeBackground;
    }
  }

  FreehandDoubleMatchObject getFreehandDoubleMatchObject(
      FreehandDoubleMatchModel match, UserResponse userInfo) {
    FreehandDoubleMatchObject result = FreehandDoubleMatchObject(
        teamMateFirstName: '',
        teamMateLastName: '',
        teamMatePhotoUrl: '',
        opponentOneFirstName: '',
        opponentOneLastName: '',
        opponentOnePhotoUrl: '',
        opponentTwoFirstName: '',
        opponentTwoLastName: '',
        opponentTwoPhotoUrl: '',
        userScore: '',
        opponentScore: '');

    if (userInfo.id == match.playerOneTeamA) {
      result.teamMateFirstName = match.playerTwoTeamAFirstName;
      result.teamMateLastName = match.playerTwoTeamALastName;
      result.teamMatePhotoUrl = match.playerTwoTeamAPhotoUrl;
      result.opponentOneFirstName = match.playerOneTeamBFirstName;
      result.opponentOneLastName = match.playerOneTeamBLastName;
      result.opponentOnePhotoUrl = match.playerOneTeamBPhotoUrl;
      result.opponentTwoFirstName = match.playerTwoTeamBFirstName;
      result.opponentTwoLastName = match.playerTwoTeamBLastName;
      result.opponentTwoPhotoUrl = match.playerTwoTeamBPhotoUrl;
      result.userScore = match.teamAScore.toString();
      result.opponentScore = match.teamBScore.toString();
    } else if (userInfo.id == match.playerTwoTeamA) {
      result.teamMateFirstName = match.playerOneTeamAFirstName;
      result.teamMateLastName = match.playerOneTeamALastName;
      result.teamMatePhotoUrl = match.playerOneTeamAPhotoUrl;
      result.opponentOneFirstName = match.playerOneTeamBFirstName;
      result.opponentOneLastName = match.playerOneTeamBLastName;
      result.opponentOnePhotoUrl = match.playerOneTeamBPhotoUrl;
      result.opponentTwoFirstName = match.playerTwoTeamBFirstName;
      result.opponentTwoLastName = match.playerTwoTeamBLastName;
      result.opponentTwoPhotoUrl = match.playerTwoTeamBPhotoUrl;
      result.userScore = match.teamAScore.toString();
      result.opponentScore = match.teamBScore.toString();
    } else if (userInfo.id == match.playerOneTeamB) {
      result.teamMateFirstName = match.playerTwoTeamBFirstName!;
      result.teamMateLastName = match.playerTwoTeamBLastName!;
      result.teamMatePhotoUrl = match.playerTwoTeamBPhotoUrl!;
      result.opponentOneFirstName = match.playerOneTeamAFirstName;
      result.opponentOneLastName = match.playerOneTeamALastName;
      result.opponentOnePhotoUrl = match.playerOneTeamAPhotoUrl;
      result.opponentTwoFirstName = match.playerTwoTeamAFirstName;
      result.opponentTwoLastName = match.playerTwoTeamALastName;
      result.opponentTwoPhotoUrl = match.playerTwoTeamAPhotoUrl;
      result.userScore = match.teamBScore.toString();
      result.opponentScore = match.teamAScore.toString();
    } else if (userInfo.id == match.playerTwoTeamB) {
      result.teamMateFirstName = match.playerOneTeamBFirstName;
      result.teamMateLastName = match.playerOneTeamBLastName;
      result.teamMatePhotoUrl = match.playerOneTeamBPhotoUrl;
      result.opponentOneFirstName = match.playerOneTeamAFirstName;
      result.opponentOneLastName = match.playerOneTeamALastName;
      result.opponentOnePhotoUrl = match.playerOneTeamAPhotoUrl;
      result.opponentTwoFirstName = match.playerTwoTeamAFirstName;
      result.opponentTwoLastName = match.playerTwoTeamALastName;
      result.opponentTwoPhotoUrl = match.playerTwoTeamAPhotoUrl;
      result.userScore = match.teamBScore.toString();
      result.opponentScore = match.teamAScore.toString();
    } else {
      result.teamMateFirstName = "";
      result.teamMateLastName = "";
      result.teamMatePhotoUrl = "";
      result.opponentOneFirstName = "";
      result.opponentOneLastName = "";
      result.opponentOnePhotoUrl = "";
      result.opponentTwoFirstName = "";
      result.opponentTwoLastName = "";
      result.opponentTwoPhotoUrl = "";
      result.userScore = "";
      result.opponentScore = "";
    }

    return result;
  }

  Color getCheckMarkColor(bool darkMode) {
    if (darkMode == true) {
      return AppColors.lightGreyDarkMode;
    } else {
      return AppColors.buttonsLightTheme;
    }
  }

  Color getCheckMarkBorderColor(bool darkMode) {
    if (darkMode == true) {
      return AppColors.white;
    } else {
      return AppColors.buttonsLightTheme;
    }
  }

  Color getButtonTextColor(bool darkMode, bool isTwoPlayers) {
    if (darkMode) {
      return AppColors.white;
    } else {
      if (isTwoPlayers) {
        return AppColors.surfaceDark;
      } else {
        return AppColors.white;
      }
    }
  }

  Color getNewGameButtonColor(bool darkMode, bool isTwoPlayers) {
    if (darkMode) {
      if (isTwoPlayers) {
        return AppColors.surfaceDark;
      } else {
        return AppColors.textGrey;
      }
    } else {
      if (isTwoPlayers) {
        return AppColors.white;
      } else {
        return AppColors.buttonsLightTheme;
      }
    }
  }

  String generateRandomString() {
    var random = Random();
    var codeUnits = List.generate(6, (index) {
      return random.nextInt(33) + 89;
    });

    return String.fromCharCodes(codeUnits);
  }

  // Alert Dialog
  Future<void> alertDialog(String title, String message, String approve,
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(approve),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> refreshToken() async {
    PreferencesService preferencesService = PreferencesService();
    String? jwtToken = await preferencesService.getJwtToken();
    String? refreshToken = await preferencesService.getRefreshToken();

    if (jwtToken != null && refreshToken != null) {
      AuthApi auth = AuthApi();
      RefreshModel refreshModel =
          RefreshModel(token: jwtToken, refreshToken: refreshToken);
      var refreshData = await auth.refresh(refreshModel);

      if (refreshData.statusCode == 200) {
        var refreshResponse = LoginResponse.fromJson(refreshData.data);
        await preferencesService.setJwtToken(refreshResponse.token);
        await preferencesService.setRefreshToken(refreshResponse.refreshToken);
        return refreshResponse.token;
      } else if (refreshData.statusCode == 400 ||
          refreshData.statusCode == 500) {
        await preferencesService.deleteRefreshToken();
        await preferencesService.deleteJwtToken();
        navigatorKey.currentState?.pushNamed('login');
        jwtToken = "ABORTAPICALL";
      }
    }
    return jwtToken;
  }

  void showSnackbar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.teal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
