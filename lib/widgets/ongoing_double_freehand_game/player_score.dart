import 'package:flutter/material.dart';
import 'package:dano_foosball/state/ongoing_double_freehand_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class PlayerScore extends StatefulWidget {
  final UserState userState;
  final bool isTeamOne;
  final OngoingDoubleFreehandState ongoingState;
  const PlayerScore(
      {Key? key,
      required this.userState,
      required this.isTeamOne,
      required this.ongoingState})
      : super(key: key);

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 90),
        child: ExtendedText(
          text: widget.isTeamOne
              ? widget.ongoingState.teamOne.score.toString()
              : widget.ongoingState.teamTwo.score.toString(),
          userState: widget.userState,
          fontSize: 40,
          isBold: true,
        ));
  }
}
