import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

import '../../api/FreehandMatchApi.dart';
import '../../models/freehand-matches/freehand_match_body.dart';
import '../../models/freehand-matches/freehand_match_model.dart';
import '../../models/other/ongoing_game_object.dart';
import '../ongoing_freehand_game/ongoing_freehand_game.dart';

class FreehandMatchButtons extends StatelessWidget {
  final UserState userState;
  final FreehandMatchModel freehandMatchData;
  const FreehandMatchButtons(
      {Key? key, required this.userState, required this.freehandMatchData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void startFreehandSingleGame() {
      FreehandMatchApi matchApi = FreehandMatchApi(token: userState.token);

      FreehandMatchBody fmb = FreehandMatchBody(
          playerOneId: freehandMatchData.playerOneId,
          playerTwoId: freehandMatchData.playerTwoId,
          playerOneScore: 0,
          playerTwoScore: 0,
          upTo: 10,
          gameFinished: false,
          gamePaused: false);

      UserResponse playerOne = UserResponse(
        id: freehandMatchData.playerOneId,
        email: '',
        firstName: freehandMatchData.playerOneFirstName,
        lastName: freehandMatchData.playerOneLastName,
        createdAt: DateTime.now(),
        currentOrganisationId: userState.currentOrganisationId,
        photoUrl: freehandMatchData.playerOnePhotoUrl,
        isAdmin: true,
        isDeleted: false,
      );

      UserResponse playerTwo = UserResponse(
        id: freehandMatchData.playerTwoId,
        email: '',
        firstName: freehandMatchData.playerTwoFirstName,
        lastName: freehandMatchData.playerTwoLastName,
        createdAt: DateTime.now(),
        currentOrganisationId: userState.currentOrganisationId,
        photoUrl: freehandMatchData.playerTwoPhotoUrl,
        isAdmin: true,
        isDeleted: false,
      );

      // create new freehand match
      matchApi.createNewFreehandMatch(fmb).then((value) {
        OngoingGameObject ongoingGameObject = OngoingGameObject(
            freehandMatchCreateResponse: value,
            playerOne: playerOne,
            playerTwo: playerTwo,
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

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.lightThemeShadowColor
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
                onPressed: () => {startFreehandSingleGame()},
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: Text(userState.hardcodedStrings.rematch),
              ),
            )),
      ],
    );
  }
}
