import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/FreehandMatchApi.dart';
import 'package:dano_foosball/models/freehand-matches/freehand_match_body.dart';
import 'package:dano_foosball/models/other/freehandMatchDetailObject.dart';
import 'package:dano_foosball/models/other/ongoing_game_object.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'ongoing_freehand_game.dart';

class MatchDetailButtons extends StatelessWidget {
  final FreehandMatchDetailObject freehandMatchDetailObject;
  final UserState userState;

  const MatchDetailButtons({
    super.key,
    required this.userState,
    required this.freehandMatchDetailObject,
  });

  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewDashboard(
            userState: userState,
          ),
        ),
      );
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
        gamePaused: false,
      );

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
            ),
          ),
        );
      });
    }

    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Button(
            onClick: rematch,
            userState: userState,
            text: userState.hardcodedStrings.rematch,
            paddingBottom: 16,
            paddingLeft: 16,
            paddingRight: 16,
            paddingTop: 16,
          ),
        ),
        Expanded(
          flex: 5,
          child: Button(
            onClick: close,
            text: userState.hardcodedStrings.close,
            userState: userState,
            paddingBottom: 16,
            paddingLeft: 16,
            paddingRight: 16,
            paddingTop: 16,
          ),
        ),
      ],
    );
  }
}
