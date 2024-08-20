import 'package:flutter/material.dart';
import 'package:dano_foosball/api/FreehandDoubleMatchApi.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:dano_foosball/models/other/freehandDoubleMatchDetailObject.dart';
import 'package:dano_foosball/models/other/ongoing_double_game_object.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/ongoing_double_freehand_game.dart';

class MatchDetailButtons extends StatelessWidget {
  final FreehandDoubleMatchDetailObject data;
  final UserState userState;

  const MatchDetailButtons({
    Key? key,
    required this.userState,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewDashboard(userState: userState),
        ),
      );
    }

    void rematch() async {
      FreehandDoubleMatchApi matchApi = FreehandDoubleMatchApi();

      FreehandDoubleMatchBody fmb = FreehandDoubleMatchBody(
        playerOneTeamA: data.teamOne.players[0].id,
        playerTwoTeamA: data.teamOne.players[1].id,
        playerOneTeamB: data.teamTwo.players[0].id,
        playerTwoTeamB: data.teamTwo.players[1].id,
        organisationId: data.freehandMatchCreateResponse!.organisationId,
        teamAScore: 0,
        teamBScore: 0,
        nicknameTeamA: null,
        nicknameTeamB: null,
        upTo: data.freehandMatchCreateResponse!.upTo,
      );

      var response = await matchApi.createNewDoubleFreehandMatch(fmb);
      OngoingDoubleGameObject gameObject = OngoingDoubleGameObject(
        userState: userState,
        freehandDoubleMatchCreateResponse: response,
        playerOneTeamA: data.teamOne.players[0],
        playerTwoTeamA: data.teamOne.players[1],
        playerOneTeamB: data.teamTwo.players[0],
        playerTwoTeamB: data.teamTwo.players[1],
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OngoingDoubleFreehandGame(
            ongoingDoubleGameObject: gameObject,
          ),
        ),
      );
    }

    return Row(
      children: <Widget>[
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
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: close,
              style: ElevatedButton.styleFrom(
                backgroundColor: userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: userState.hardcodedStrings.close,
                userState: userState,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
