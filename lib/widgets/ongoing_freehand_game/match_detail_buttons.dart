import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_body.dart';
import 'package:foosball_mobile_app/models/other/freehandMatchDetailObject.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/dashboard/New_Dashboard.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'ongoing_freehand_game.dart';

class MatchDetailButtons extends StatelessWidget {
  final FreehandMatchDetailObject freehandMatchDetailObject;
  final UserState userState;
  const MatchDetailButtons(
      {Key? key,
      required this.userState,
      required this.freehandMatchDetailObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewDashboard(
                    userState: userState,
                  )));
    }

    void rematch() {
      FreehandMatchApi matchApi = FreehandMatchApi();

      FreehandMatchBody fmb = FreehandMatchBody(
          playerOneId: freehandMatchDetailObject.playerOne.id,
          playerTwoId: freehandMatchDetailObject.playerTwo.id,
          playerOneScore: 0,
          playerTwoScore: 0,
          upTo: 10,
          gameFinished: false,
          gamePaused: false);

      matchApi.createNewFreehandMatch(fmb).then((value) {
        OngoingGameObject gameObject = OngoingGameObject(
          userState: freehandMatchDetailObject.userState,
          freehandMatchCreateResponse: value,
          playerOne: freehandMatchDetailObject.playerOne,
          playerTwo: freehandMatchDetailObject.playerTwo,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OngoingFreehandGame(
                      ongoingGameObject: gameObject,
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
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: ExtendedText(
                  text: userState.hardcodedStrings.rematch,
                  userState: userState,
                   colorOverride: userState.darkmode ? AppColors.white : AppColors.white,
                ),
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
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: ExtendedText(
                  text: userState.hardcodedStrings.close,
                  userState: userState,
                  colorOverride: userState.darkmode ? AppColors.white : AppColors.white,
                ),
              ),
            )),
      ],
    );
  }
}
