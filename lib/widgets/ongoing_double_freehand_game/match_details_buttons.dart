import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:foosball_mobile_app/models/other/freehandDoubleMatchDetailObject.dart';
import 'package:foosball_mobile_app/models/other/ongoing_double_game_object.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/ongoing_double_freehand_game.dart';
import '../dashboard/Dashboard.dart';

class MatchDetailButtons extends StatelessWidget {
  final FreehandDoubleMatchDetailObject data;
  final UserState userState;
  const MatchDetailButtons(
      {Key? key, required this.userState, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    param: userState,
                  )));
    }

    void rematch() {
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
          upTo: data.freehandMatchCreateResponse!.upTo);

      matchApi.createNewDoubleFreehandMatch(fmb).then((value) {
        OngoingDoubleGameObject gameObject = OngoingDoubleGameObject(
          userState: userState,
          freehandDoubleMatchCreateResponse: value,
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
                onPressed: () => {
                  rematch(),
                },
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: Text(userState.hardcodedStrings.rematch),
              ),
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {
                  close(),
                },
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: Text(userState.hardcodedStrings.close),
              ),
            )),
      ],
    );
  }
}
