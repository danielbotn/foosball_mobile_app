import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_body.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/ongoing_freehand_game.dart';

class StartGameButton extends StatelessWidget {
  final UserState userState;
  final NewGameState newGameState;
  const StartGameButton({Key? key, required this.userState, required this.newGameState}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      
      void startGame() {
        FreehandMatchApi matchApi =
            new FreehandMatchApi(token: userState.token);

        if (newGameState.twoOrFourPlayers &&
            newGameState.playersTeamOne.length == 1 &&
            newGameState.playersTeamTwo.length == 1) {
          FreehandMatchBody fmb = new FreehandMatchBody(
              playerOneId: newGameState.playersTeamOne[0].id,
              playerTwoId: newGameState.playersTeamTwo[0].id,
              playerOneScore: 0,
              playerTwoScore: 0,
              upTo: 10,
              gameFinished: false,
              gamePaused: false);
          // create new freehand match
          matchApi.createNewFreehandMatch(fmb).then((value) {
            OngoingGameObject ongoingGameObject = OngoingGameObject(
                freehandMatchCreateResponse: value,
                playerOne: newGameState.playersTeamOne[0],
                playerTwo: newGameState.playersTeamTwo[0],
                userState: userState);
            // clear state of newGameState
            // newGameState.clearState();

            // navigate to game screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OngoingFreehandGame(
                          ongoingGameObject: ongoingGameObject,
                        )));
          });
        } else {
          // create new double freehand match
        }
      }

      return Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () => {
                      startGame(),
                    },
                    child: Text(userState.hardcodedStrings.startGame),
                    style: ElevatedButton.styleFrom(
                        primary: userState.darkmode
                            ? AppColors.lightThemeShadowColor
                            : AppColors.buttonsLightTheme,
                        minimumSize: Size(100, 50)),
                  ),
                ),
              )),
        ],
      );

  }
}
