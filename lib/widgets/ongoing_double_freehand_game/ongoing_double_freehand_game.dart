import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/other/ongoing_double_game_object.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/ongoing_double_freehand_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/buttons.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/player_card.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/player_score.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/time_keeper.dart';

import '../extended_Text.dart';

class OngoingDoubleFreehandGame extends StatefulWidget {
  final OngoingDoubleGameObject ongoingDoubleGameObject;
  OngoingDoubleFreehandGame({Key? key, required this.ongoingDoubleGameObject})
      : super(key: key);

  @override
  State<OngoingDoubleFreehandGame> createState() =>
      _OngoingDoubleFreehandGameState();
}

class _OngoingDoubleFreehandGameState extends State<OngoingDoubleFreehandGame> {
  final OngoingDoubleFreehandState ongoingState = OngoingDoubleFreehandState();
  String randomStringStopClock = '';
  String randomString = '';

  @override
  void initState() {
    super.initState();
    UserResponse playerOneTeamA = widget.ongoingDoubleGameObject.playerOneTeamA;
    UserResponse playerTwoTeamA = widget.ongoingDoubleGameObject.playerTwoTeamA;
    UserResponse playerOneTeamB = widget.ongoingDoubleGameObject.playerOneTeamB;
    UserResponse playerTwoTeamB = widget.ongoingDoubleGameObject.playerTwoTeamB;
    ongoingState.setTeamOne(playerOneTeamA, playerTwoTeamA, 0);
    ongoingState.setTeamTwo(playerOneTeamB, playerTwoTeamB, 0);
  }

  void refreshScoreWidget() {
    setState(() {});
  }

  // used to rebuild widget
  void refresh() {
    setState(() {});
    setRandomString();
  }

  void setRandomStringStopClock() {
    Helpers helpers = Helpers();
    var randomString = helpers.generateRandomString();
    setState(() {
      this.randomStringStopClock = randomString;
    });
  }

  void setRandomString() {
    Helpers helpers = Helpers();
    var randomString = helpers.generateRandomString();
    setState(() {
      this.randomString = randomString;
    });
  }

  void stopClockFromChild() {
    setRandomStringStopClock();
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget
                    .ongoingDoubleGameObject.userState.hardcodedStrings.newGame,
                userState: widget.ongoingDoubleGameObject.userState),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(
                widget.ongoingDoubleGameObject.userState.darkmode),
            backgroundColor: helpers.getBackgroundColor(
                widget.ongoingDoubleGameObject.userState.darkmode)),
        body: Container(
          color: helpers.getBackgroundColor(
              widget.ongoingDoubleGameObject.userState.darkmode),
          child: Column(
            children: [
              TimeKeeper(
                  ongoingGameObject: widget.ongoingDoubleGameObject,
                  counter: ongoingState,
                  randomString: randomString,
                  randomStringStopClock: randomStringStopClock),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        PlayerCard(
                          ongoingDoubleGameObject:
                              widget.ongoingDoubleGameObject,
                          userState: widget.ongoingDoubleGameObject.userState,
                          ongoingState: ongoingState,
                          player: ongoingState.teamOne.players[0],
                          whichPlayer: 'teamOnePlayerOne',
                          notifyParent: refreshScoreWidget,
                          stopClockFromChild: stopClockFromChild,
                        ),
                        PlayerCard(
                          ongoingDoubleGameObject:
                              widget.ongoingDoubleGameObject,
                          userState: widget.ongoingDoubleGameObject.userState,
                          ongoingState: ongoingState,
                          player: ongoingState.teamOne.players[1],
                          whichPlayer: 'teamOnePlayerTwo',
                          notifyParent: refreshScoreWidget,
                          stopClockFromChild: stopClockFromChild,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: PlayerScore(
                        userState: widget.ongoingDoubleGameObject.userState,
                        isTeamOne: true,
                        ongoingState: ongoingState,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        PlayerCard(
                          ongoingDoubleGameObject:
                              widget.ongoingDoubleGameObject,
                          userState: widget.ongoingDoubleGameObject.userState,
                          ongoingState: ongoingState,
                          player: ongoingState.teamTwo.players[0],
                          whichPlayer: 'teamTwoPlayerOne',
                          notifyParent: refreshScoreWidget,
                          stopClockFromChild: stopClockFromChild,
                        ),
                        PlayerCard(
                          ongoingDoubleGameObject:
                              widget.ongoingDoubleGameObject,
                          userState: widget.ongoingDoubleGameObject.userState,
                          ongoingState: ongoingState,
                          player: ongoingState.teamTwo.players[1],
                          whichPlayer: 'teamTwoPlayerTwo',
                          notifyParent: refreshScoreWidget,
                          stopClockFromChild: stopClockFromChild,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: PlayerScore(
                        userState: widget.ongoingDoubleGameObject.userState,
                        isTeamOne: false,
                        ongoingState: ongoingState,
                      ))
                ],
              ),
              Spacer(),
              Buttons(
                ongoingState: ongoingState,
                notifyParent: refresh,
                userState: widget.ongoingDoubleGameObject.userState,
              )
            ],
          ),
        ));
  }
}
