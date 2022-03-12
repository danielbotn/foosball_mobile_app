// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:foosball_mobile_app/models/other/freehandDoubleMatchObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';

import 'app_color.dart';

class Helpers {
  IconThemeData getIconTheme(bool darkMode) {
    if (darkMode == true) {
      return IconThemeData(color: AppColors.white);
    } else {
      return IconThemeData(color: Colors.grey[700]);
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
    FreehandDoubleMatchObject result = new FreehandDoubleMatchObject(
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

  Color getButtonTextColor(bool darkMode, bool isTwoPlayers) {
    if (darkMode) {
      return AppColors.blue;
    } else {
      if (isTwoPlayers) {
        return AppColors.textBlack;
      } else {
        return AppColors.white;
      }
    }
  }

  Color getNewGameButtonColor(bool darkMode, bool isTwoPlayers) {
    if (darkMode) {
      return AppColors.darkModeBackground;
    } else {
      if (isTwoPlayers) {
        return AppColors.white;
      } else {
        return AppColors.buttonsLightTheme;
      }
    }
  }
}
