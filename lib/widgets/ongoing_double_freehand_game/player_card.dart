import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleGoalsApi.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_body.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_return.dart';
import 'package:foosball_mobile_app/models/other/freehandDoubleMatchDetailObject.dart';
import 'package:foosball_mobile_app/models/other/ongoing_double_game_object.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/ongoing_double_freehand_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/ongoing_double_freehand_game/match_details.dart';
import '../extended_Text.dart';

class PlayerCard extends StatefulWidget {
  final OngoingDoubleGameObject ongoingDoubleGameObject;
  final UserState userState;
  final OngoingDoubleFreehandState ongoingState;
  final UserResponse player;
  final String whichPlayer;
  final Function() notifyParent;
  final Function() stopClockFromChild;
  PlayerCard(
      {Key? key,
      required this.ongoingDoubleGameObject,
      required this.userState,
      required this.ongoingState,
      required this.player,
      required this.whichPlayer,
      required this.notifyParent,
      required this.stopClockFromChild})
      : super(key: key);

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  int getScorerScore() {
    int score = 0;
    if (widget.whichPlayer == "teamOnePlayerOne") {
      score = widget.ongoingState.teamOne.score + 1;
    } else if (widget.whichPlayer == "teamOnePlayerTwo") {
      score = widget.ongoingState.teamOne.score + 1;
    } else if (widget.whichPlayer == "teamTwoPlayerOne") {
      score = widget.ongoingState.teamTwo.score + 1;
    } else if (widget.whichPlayer == "teamTwoPlayerTwo") {
      score = widget.ongoingState.teamTwo.score + 1;
    }
    return score;
  }

  int getOpponentScore() {
    int score = 0;
    if (widget.whichPlayer == "teamOnePlayerOne") {
      score = widget.ongoingState.teamTwo.score;
    } else if (widget.whichPlayer == "teamOnePlayerTwo") {
      score = widget.ongoingState.teamTwo.score;
    } else if (widget.whichPlayer == "teamTwoPlayerOne") {
      score = widget.ongoingState.teamOne.score;
    } else if (widget.whichPlayer == "teamTwoPlayerTwo") {
      score = widget.ongoingState.teamOne.score;
    }
    return score;
  }

  Future<FreehandDoubleGoalReturn?> updateScoreToDatabase() async {
    FreehandDoubleGoalsApi freehandDoubleGoalsApi =
        new FreehandDoubleGoalsApi(token: '${widget.userState.token}');
    int upTo =
        widget.ongoingDoubleGameObject.freehandDoubleMatchCreateResponse!.upTo;

    FreehandDoubleGoalBody body = new FreehandDoubleGoalBody(
      doubleMatchId:
          widget.ongoingDoubleGameObject.freehandDoubleMatchCreateResponse!.id,
      scoredByUserId: widget.player.id,
      scorerTeamScore: getScorerScore(),
      opponentTeamScore: getOpponentScore(),
      winnerGoal: getScorerScore() >= upTo - 1,
    );
    return await freehandDoubleGoalsApi.createDoubleFreehandGoal(body);
  }

  void increaseScore() async {
    int upTo =
        widget.ongoingDoubleGameObject.freehandDoubleMatchCreateResponse!.upTo;
    var update = await updateScoreToDatabase();

    if (update != null) {
      if (widget.whichPlayer == "teamOnePlayerOne") {
        widget.ongoingState.setScoreTeamOne(update.scorerTeamScore);
      } else if (widget.whichPlayer == "teamOnePlayerTwo") {
        widget.ongoingState.setScoreTeamOne(update.scorerTeamScore);
      } else if (widget.whichPlayer == "teamTwoPlayerOne") {
        widget.ongoingState.setScoreTeamTwo(update.scorerTeamScore);
      } else if (widget.whichPlayer == "teamTwoPlayerTwo") {
        widget.ongoingState.setScoreTeamTwo(update.scorerTeamScore);
      }
      widget.notifyParent();

      if (widget.ongoingState.teamOne.score == upTo ||
          widget.ongoingState.teamTwo.score == upTo) {
        gameIsFinished();
      }
    }
  }

  void gameIsFinished() {
    FreehandDoubleMatchDetailObject fdmdo =
        new FreehandDoubleMatchDetailObject(
      userState: widget.userState,
      freehandMatchCreateResponse: widget.ongoingDoubleGameObject
          .freehandDoubleMatchCreateResponse,
      teamOne: widget.ongoingState.teamOne,
      teamTwo: widget.ongoingState.teamTwo,
    );
    
    widget.stopClockFromChild();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MatchDetails(
                  data: fdmdo,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          increaseScore();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
          child: Row(
            children: [
              Column(
                children: [
                  Image.network(widget.player.photoUrl, width: 40, height: 40),
                ],
              ),
              Column(
                children: [
                  ExtendedText(
                      text: widget.player.firstName,
                      userState: this.widget.userState),
                  ExtendedText(
                      text: widget.player.lastName,
                      userState: this.widget.userState),
                ],
              ),
            ],
          ),
        ));
  }
}
