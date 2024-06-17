import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:foosball_mobile_app/models/other/ongoing_double_game_object.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/new_game/new_game.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/ongoing_double_freehand_game.dart';

class FreehandDoubleMatchButtons extends StatelessWidget {
  final UserState userState;
  final FreehandDoubleMatchModel matchData;
  const FreehandDoubleMatchButtons(
      {Key? key, required this.userState, required this.matchData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void newMatch() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewGame(
                    userState: userState,
                  )));
    }

    void rematch() {
      FreehandDoubleMatchApi doubleMatchApi = FreehandDoubleMatchApi();
      FreehandDoubleMatchBody fdmb = FreehandDoubleMatchBody(
        playerOneTeamA: matchData.playerOneTeamA,
        playerTwoTeamA: matchData.playerTwoTeamA,
        playerOneTeamB: matchData.playerOneTeamB,
        playerTwoTeamB: matchData.playerTwoTeamB,
        organisationId: userState.currentOrganisationId,
        teamAScore: 0,
        teamBScore: 0,
        nicknameTeamA: null,
        nicknameTeamB: null,
        upTo: 10,
      );
      UserResponse playerOneTeamA = UserResponse(
        id: matchData.playerOneTeamA,
        email: '',
        firstName: matchData.playerOneTeamAFirstName,
        lastName: matchData.playerOneTeamALastName,
        createdAt: DateTime.now(),
        currentOrganisationId: userState.currentOrganisationId,
        photoUrl: matchData.playerOneTeamAPhotoUrl,
        isAdmin: true,
        isDeleted: false,
      );
      UserResponse playerTwoTeamA = UserResponse(
        id: matchData.playerTwoTeamA,
        email: '',
        firstName: matchData.playerTwoTeamAFirstName,
        lastName: matchData.playerTwoTeamALastName,
        createdAt: DateTime.now(),
        currentOrganisationId: userState.currentOrganisationId,
        photoUrl: matchData.playerTwoTeamAPhotoUrl,
        isAdmin: true,
        isDeleted: false,
      );
      UserResponse playerOneTeamB = UserResponse(
        id: matchData.playerOneTeamB,
        email: '',
        firstName: matchData.playerOneTeamBFirstName,
        lastName: matchData.playerOneTeamBLastName,
        createdAt: DateTime.now(),
        currentOrganisationId: userState.currentOrganisationId,
        photoUrl: matchData.playerOneTeamBPhotoUrl,
        isAdmin: true,
        isDeleted: false,
      );
      UserResponse? playerTwoTeamB;

      if (matchData.playerTwoTeamB != null) {
        playerTwoTeamB = UserResponse(
          id: matchData.playerTwoTeamB as int,
          email: '',
          firstName: matchData.playerTwoTeamBFirstName as String,
          lastName: matchData.playerTwoTeamBLastName as String,
          createdAt: DateTime.now(),
          currentOrganisationId: userState.currentOrganisationId,
          photoUrl: matchData.playerTwoTeamBPhotoUrl as String,
          isAdmin: true,
          isDeleted: false,
        );
      }

      doubleMatchApi.createNewDoubleFreehandMatch(fdmb).then((value) {
        OngoingDoubleGameObject ongoingDoubleGameObject =
            OngoingDoubleGameObject(
                freehandDoubleMatchCreateResponse: value,
                playerOneTeamA: playerOneTeamA,
                playerTwoTeamA: playerTwoTeamA,
                playerOneTeamB: playerOneTeamB,
                playerTwoTeamB: playerTwoTeamB ?? playerTwoTeamB,
                userState: userState);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OngoingDoubleFreehandGame(
                      ongoingDoubleGameObject: ongoingDoubleGameObject,
                    )));
      });
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {newMatch()},
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: Text(userState.hardcodedStrings.newMatch),
              ),
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {rematch()},
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: Text(userState.hardcodedStrings.rematch),
              ),
            )),
      ],
    );
  }
}
