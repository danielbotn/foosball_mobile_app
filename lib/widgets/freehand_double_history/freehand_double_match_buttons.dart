import 'package:flutter/material.dart';
import 'package:dano_foosball/api/FreehandDoubleMatchApi.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:dano_foosball/models/other/ongoing_double_game_object.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/new_game/new_game.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/ongoing_double_freehand_game.dart';

class FreehandDoubleMatchButtons extends StatelessWidget {
  final UserState userState;
  final FreehandDoubleMatchModel matchData;

  const FreehandDoubleMatchButtons({
    Key? key,
    required this.userState,
    required this.matchData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void newMatch() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewGame(userState: userState),
        ),
      );
    }

    void rematch() {
      final FreehandDoubleMatchApi doubleMatchApi = FreehandDoubleMatchApi();
      final FreehandDoubleMatchBody fdmb = FreehandDoubleMatchBody(
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

      final UserResponse playerOneTeamA = UserResponse(
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

      final UserResponse playerTwoTeamA = UserResponse(
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

      final UserResponse playerOneTeamB = UserResponse(
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

      final UserResponse? playerTwoTeamB = matchData.playerTwoTeamB != null
          ? UserResponse(
              id: matchData.playerTwoTeamB!,
              email: '',
              firstName: matchData.playerTwoTeamBFirstName!,
              lastName: matchData.playerTwoTeamBLastName!,
              createdAt: DateTime.now(),
              currentOrganisationId: userState.currentOrganisationId,
              photoUrl: matchData.playerTwoTeamBPhotoUrl!,
              isAdmin: true,
              isDeleted: false,
            )
          : null;

      doubleMatchApi.createNewDoubleFreehandMatch(fdmb).then((value) {
        final OngoingDoubleGameObject ongoingDoubleGameObject =
            OngoingDoubleGameObject(
          freehandDoubleMatchCreateResponse: value,
          playerOneTeamA: playerOneTeamA,
          playerTwoTeamA: playerTwoTeamA,
          playerOneTeamB: playerOneTeamB,
          playerTwoTeamB: playerTwoTeamB,
          userState: userState,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OngoingDoubleFreehandGame(
              ongoingDoubleGameObject: ongoingDoubleGameObject,
            ),
          ),
        );
      });
    }

    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: newMatch,
              style: ElevatedButton.styleFrom(
                backgroundColor: userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: userState.hardcodedStrings.newMatch,
                userState: userState,
                colorOverride: AppColors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: rematch,
              style: ElevatedButton.styleFrom(
                backgroundColor: userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: userState.hardcodedStrings.rematch,
                userState: userState,
                colorOverride: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
