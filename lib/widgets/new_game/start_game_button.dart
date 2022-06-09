import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleMatchApi.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_body.dart';
import 'package:foosball_mobile_app/models/other/ongoing_double_game_object.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/ongoing_double_freehand_game.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/ongoing_freehand_game.dart';

class StartGameButton extends StatelessWidget {
  final UserState userState;
  final NewGameState newGameState;
  const StartGameButton(
      {Key? key, required this.userState, required this.newGameState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    void startFreehandSingleGame() {
      FreehandMatchApi matchApi = new FreehandMatchApi(token: userState.token);

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
         
          // navigate to game screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OngoingFreehandGame(
                        ongoingGameObject: ongoingGameObject,
                      )));
        });
    }

    void startFreehandDoubleGame() {
      FreehandDoubleMatchApi doubleMatchApi =
          FreehandDoubleMatchApi(token: userState.token);
      FreehandDoubleMatchBody fdmb = FreehandDoubleMatchBody(
          playerOneTeamA: newGameState.playersTeamOne[0].id,
          playerTwoTeamA: newGameState.playersTeamOne[1].id,
          playerOneTeamB: newGameState.playersTeamTwo[0].id,
          playerTwoTeamB: newGameState.playersTeamTwo[1].id,
          organisationId: newGameState.playersTeamOne[0].currentOrganisationId as int,
          teamAScore: 0,
          teamBScore: 0,
          nicknameTeamA: null,
          nicknameTeamB: null,
          upTo: 10,
        );
        doubleMatchApi.createNewDoubleFreehandMatch(fdmb).then((value) {
          OngoingDoubleGameObject ongoingDoubleGameObject =
              OngoingDoubleGameObject(
                  freehandDoubleMatchCreateResponse: value,
                  playerOneTeamA: newGameState.playersTeamOne[0],
                  playerTwoTeamA: newGameState.playersTeamOne[1],
                  playerOneTeamB: newGameState.playersTeamTwo[0],
                  playerTwoTeamB: newGameState.playersTeamTwo[1],
                  userState: userState);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OngoingDoubleFreehandGame(
                        ongoingDoubleGameObject: ongoingDoubleGameObject,
                      )));
        });
    }

    void startGame() {
      if (newGameState.twoOrFourPlayers &&
          newGameState.playersTeamOne.length == 1 &&
          newGameState.playersTeamTwo.length == 1) {
        startFreehandSingleGame();
      } else {
        startFreehandDoubleGame();
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
                  style: ElevatedButton.styleFrom(
                      primary: userState.darkmode
                          ? AppColors.lightThemeShadowColor
                          : AppColors.buttonsLightTheme,
                      minimumSize: Size(100, 50)),
                  child: Text(userState.hardcodedStrings.startGame),
                ),
              ),
            )),
      ],
    );
  }
}
