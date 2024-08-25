import 'package:flutter/material.dart';
import 'package:dano_foosball/state/ongoing_freehand_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class PlayerScore extends StatefulWidget {
  final UserState userState;
  final bool isPlayerOne;
  final OngoingFreehandState counter;
  final String randomString;
  final int? overrideScore; // Optional property to override score

  const PlayerScore({
    super.key,
    required this.userState,
    required this.isPlayerOne,
    required this.counter,
    required this.randomString,
    this.overrideScore, // Initialize the optional property
  });

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  @override
  Widget build(BuildContext context) {
    // Determine the score to display
    int displayScore = widget.overrideScore ??
        (widget.isPlayerOne
            ? widget.counter.playerOne.score
            : widget.counter.playerTwo.score);

    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: ExtendedText(
        text: displayScore.toString(),
        userState: widget.userState,
        fontSize: 40,
        isBold: true,
      ),
    );
  }
}
