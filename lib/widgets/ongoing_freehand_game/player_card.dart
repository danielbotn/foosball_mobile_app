import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandGoalsApi.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goal_body.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goal_model.dart';
import 'package:foosball_mobile_app/models/other/freehandMatchDetailObject.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import '../extended_Text.dart';
import 'match_details.dart';

class PlayerCard extends StatefulWidget {
  final OngoingGameObject ongoingGameObject;
  final UserState userState;
  final bool isPlayerOne;
  final OngoingFreehandState counter;
  final Function() notifyParent;
  final Function() stopClockFromChild;
  PlayerCard(
      {Key? key,
      required this.ongoingGameObject,
      required this.userState,
      required this.isPlayerOne,
      required this.counter,
      required this.notifyParent,
      required this.stopClockFromChild})
      : super(key: key);

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  Future<FreehandGoalModel?> updateScoreToDatabase(bool isPlayerOne) async {
    FreehandGoalsApi freehandGoalsApi = FreehandGoalsApi();

    int upTo = widget.ongoingGameObject.freehandMatchCreateResponse!.upTo;

    FreehandGoalBody body = FreehandGoalBody(
        matchId: widget.ongoingGameObject.freehandMatchCreateResponse!.id,
        scoredByUserId: isPlayerOne
            ? widget.ongoingGameObject.playerOne.id
            : widget.ongoingGameObject.playerTwo.id,
        oponentId: isPlayerOne
            ? widget.ongoingGameObject.playerTwo.id
            : widget.ongoingGameObject.playerOne.id,
        scoredByScore: isPlayerOne
            ? widget.counter.playerOne.score + 1
            : widget.counter.playerTwo.score + 1,
        oponentScore: isPlayerOne
            ? widget.counter.playerTwo.score
            : widget.counter.playerOne.score,
        winnerGoal: isPlayerOne
            ? widget.counter.playerOne.score >= upTo - 1
            : widget.counter.playerTwo.score >= upTo - 1);
    return await freehandGoalsApi.createFreehandGoal(body);
  }

  void increaseScore() async {
    int upTo = widget.ongoingGameObject.freehandMatchCreateResponse!.upTo;
    if (widget.isPlayerOne) {
      var update = await updateScoreToDatabase(true);
      if (update != null) {
        widget.counter.updatePlayerOneScore(widget.counter.playerOne.score + 1);
      }
    } else {
      var update = await updateScoreToDatabase(false);
      if (update != null) {
        widget.counter.updatePlayerTwoScore(widget.counter.playerTwo.score + 1);
      }
    }
    widget.notifyParent();

    if (widget.counter.playerOne.score == upTo ||
        widget.counter.playerTwo.score == upTo) {
      gameIsFinished();
    }
  }

  void gameIsFinished() {
    // go to the finished screen
    FreehandMatchDetailObject fmdo = FreehandMatchDetailObject(
        freehandMatchCreateResponse:
            widget.ongoingGameObject.freehandMatchCreateResponse,
        playerOne: widget.ongoingGameObject.playerOne,
        playerTwo: widget.ongoingGameObject.playerTwo,
        userState: widget.userState);
    widget.stopClockFromChild();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MatchDetails(
                  freehandMatchDetailObject: fmdo,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          increaseScore();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Image.network(
                      widget.isPlayerOne
                          ? widget.ongoingGameObject.playerOne.photoUrl
                          : widget.ongoingGameObject.playerTwo.photoUrl,
                      width: 60,
                      height: 60),
                ],
              ),
              Column(
                children: [
                  ExtendedText(
                      text: widget.isPlayerOne
                          ? widget.ongoingGameObject.playerOne.firstName
                          : widget.ongoingGameObject.playerTwo.firstName,
                      userState: this.widget.userState),
                  ExtendedText(
                      text: widget.isPlayerOne
                          ? widget.ongoingGameObject.playerOne.lastName
                          : widget.ongoingGameObject.playerTwo.lastName,
                      userState: this.widget.userState),
                ],
              ),
            ],
          ),
        ));
  }
}
