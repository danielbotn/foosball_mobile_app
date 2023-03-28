import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleGoalsApi.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_model.dart';
import 'package:foosball_mobile_app/models/other/ongoing_double_game_object.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/ongoing_double_freehand_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/dashboard/Dashboard.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/buttons.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/player_card.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/player_score.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/time_keeper.dart';
import '../extended_Text.dart';

class OngoingDoubleFreehandGame extends StatefulWidget {
  final OngoingDoubleGameObject ongoingDoubleGameObject;
  const OngoingDoubleFreehandGame(
      {Key? key, required this.ongoingDoubleGameObject})
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
    UserResponse playerTwoTeamB =
        widget.ongoingDoubleGameObject.playerTwoTeamB as UserResponse;
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

  void closeAlertDialog() {
    // delete freehand game and goals and then navigate back to dashboard
    FreehandDoubleMatchApi freehandMatchApi = FreehandDoubleMatchApi();
    freehandMatchApi
        .deleteDoubleFreehandMatch(widget
            .ongoingDoubleGameObject.freehandDoubleMatchCreateResponse!.id)
        .then((value) {
      if (value == true) {
        // go to dashboard screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      param: widget.ongoingDoubleGameObject.userState,
                    )));
      }
    });
  }

  Future<void> showAlertModal(BuildContext context) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(widget.ongoingDoubleGameObject.userState
                .hardcodedStrings.areYouSureAlert),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 'Yes');
                    },
                    child: Text(widget.ongoingDoubleGameObject.userState
                        .hardcodedStrings.yes),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 'No');
                    },
                    child: Text(widget
                        .ongoingDoubleGameObject.userState.hardcodedStrings.no),
                  ),
                ],
              )
            ],
          );
        })) {
      case 'Yes':
        stopClockFromChild();
        closeAlertDialog();
        break;
      case 'No':
        break;
    }
  }

  Future<List<FreehandDoubleGoalModel>?> getAllDoubleFreehandGames(
      int matchId) async {
    FreehandDoubleGoalsApi freehandMatchApi = FreehandDoubleGoalsApi();
    return await freehandMatchApi.getFreehandDoubleGoals(matchId);
  }

  Future<bool> deleteGoal(int matchId, int goalId) async {
    FreehandDoubleGoalsApi freehandMatchApi = FreehandDoubleGoalsApi();
    return await freehandMatchApi.deleteFreehandDoubleGoal(goalId, matchId);
  }

  void deleteLastScoredGoal() async {
    if (ongoingState.teamOne.score > 0 || ongoingState.teamTwo.score > 0) {
      // Get all goals
      List<FreehandDoubleGoalModel>? goals = await getAllDoubleFreehandGames(
          widget.ongoingDoubleGameObject.freehandDoubleMatchCreateResponse!.id);
      if (goals != null) {
        // Get last goal
        FreehandDoubleGoalModel lastGoal = goals.last;
        // Delete last goal
        bool success = await deleteGoal(
            widget
                .ongoingDoubleGameObject.freehandDoubleMatchCreateResponse!.id,
            lastGoal.id);
        if (success) {
          if (widget.ongoingDoubleGameObject.playerOneTeamA.id ==
                  lastGoal.scoredByUserId ||
              widget.ongoingDoubleGameObject.playerTwoTeamA.id == lastGoal.id) {
            int currentCount = ongoingState.teamOne.score;
            ongoingState.setScoreTeamOne(currentCount - 1);
          } else {
            int currentCount = ongoingState.teamTwo.score;
            ongoingState.setScoreTeamTwo(currentCount - 1);
          }
        }
      }
    }
    refreshScoreWidget();
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
            icon: const Icon(Icons.close),
            onPressed: () {
              showAlertModal(context);
            },
          ),
          iconTheme: helpers
              .getIconTheme(widget.ongoingDoubleGameObject.userState.darkmode),
          backgroundColor: helpers.getBackgroundColor(
              widget.ongoingDoubleGameObject.userState.darkmode),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    deleteLastScoredGoal();
                  },
                  child: const Icon(
                    Icons.undo,
                    size: 26.0,
                  ),
                )),
          ],
        ),
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
              const Spacer(),
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
