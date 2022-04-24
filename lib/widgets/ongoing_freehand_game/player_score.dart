import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class PlayerScore extends StatefulWidget {
  final UserState userState;
  final bool isPlayerOne;
  final OngoingFreehandState counter;
  final String randomString;
  PlayerScore(
      {Key? key,
      required this.userState,
      required this.isPlayerOne,
      required this.counter,
      required this.randomString
      })
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
          text: widget.isPlayerOne
              ? widget.counter.playerOne.score.toString()
              : widget.counter.playerTwo.score.toString(),
          userState: widget.userState,
          fontSize: 40,
          isBold: true,
        ));
  }
}
