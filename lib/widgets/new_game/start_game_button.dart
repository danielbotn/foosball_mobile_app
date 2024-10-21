import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/FreehandDoubleMatchApi.dart';
import 'package:dano_foosball/api/FreehandMatchApi.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_body.dart';
import 'package:dano_foosball/models/freehand-matches/freehand_match_body.dart';
import 'package:dano_foosball/models/other/ongoing_double_game_object.dart';
import 'package:dano_foosball/models/other/ongoing_game_object.dart';
import 'package:dano_foosball/state/new_game_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/ongoing_double_freehand_game.dart';
import 'package:dano_foosball/widgets/ongoing_freehand_game/ongoing_freehand_game.dart';

class StartGameButton extends StatelessWidget {
  final UserState userState;
  final NewGameState newGameState;
  final String buttonText;

  const StartGameButton({
    Key? key,
    required this.userState,
    required this.newGameState,
    required this.buttonText,
  }) : super(key: key);

  void _startFreehandSingleGame(BuildContext context) {
    FreehandMatchApi matchApi = FreehandMatchApi();
    FreehandMatchBody fmb = FreehandMatchBody(
      playerOneId: newGameState.playersTeamOne[0].id,
      playerTwoId: newGameState.playersTeamTwo[0].id,
      playerOneScore: 0,
      playerTwoScore: 0,
      upTo: 10,
      gameFinished: false,
      gamePaused: false,
    );

    matchApi.createNewFreehandMatch(fmb).then((value) {
      OngoingGameObject ongoingGameObject = OngoingGameObject(
        freehandMatchCreateResponse: value,
        playerOne: newGameState.playersTeamOne[0],
        playerTwo: newGameState.playersTeamTwo[0],
        userState: userState,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OngoingFreehandGame(
            ongoingGameObject: ongoingGameObject,
          ),
        ),
      );
    });
  }

  void _startFreehandDoubleGame(BuildContext context) {
    FreehandDoubleMatchApi doubleMatchApi = FreehandDoubleMatchApi();
    FreehandDoubleMatchBody fdmb = FreehandDoubleMatchBody(
      playerOneTeamA: newGameState.playersTeamOne[0].id,
      playerTwoTeamA: newGameState.playersTeamOne[1].id,
      playerOneTeamB: newGameState.playersTeamTwo[0].id,
      playerTwoTeamB: newGameState.playersTeamTwo[1].id,
      organisationId: newGameState.playersTeamOne[0].currentOrganisationId!,
      teamAScore: 0,
      teamBScore: 0,
      nicknameTeamA: null,
      nicknameTeamB: null,
      upTo: 10,
    );

    doubleMatchApi.createNewDoubleFreehandMatch(fdmb).then((value) {
      OngoingDoubleGameObject ongoingDoubleGameObject = OngoingDoubleGameObject(
        freehandDoubleMatchCreateResponse: value,
        playerOneTeamA: newGameState.playersTeamOne[0],
        playerTwoTeamA: newGameState.playersTeamOne[1],
        playerOneTeamB: newGameState.playersTeamTwo[0],
        playerTwoTeamB: newGameState.playersTeamTwo[1],
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

  void _startGame(BuildContext context) {
    if (newGameState.twoOrFourPlayers &&
        newGameState.playersTeamOne.length == 1 &&
        newGameState.playersTeamTwo.length == 1) {
      _startFreehandSingleGame(context);
    } else {
      _startFreehandDoubleGame(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () => _startGame(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: buttonText,
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
