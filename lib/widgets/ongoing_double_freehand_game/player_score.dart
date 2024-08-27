import 'package:flutter/material.dart';
import 'package:dano_foosball/state/ongoing_double_freehand_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class PlayerScore extends StatefulWidget {
  final UserState userState;
  final bool isTeamOne;
  final OngoingDoubleFreehandState? ongoingState; // Make this nullable
  final int? overrideScore; // Optional prop to override the score

  const PlayerScore({
    super.key,
    required this.userState,
    required this.isTeamOne,
    this.ongoingState, // Allow null value
    this.overrideScore, // Optional parameter
  });

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  @override
  Widget build(BuildContext context) {
    // If ongoingState is null, default score to 0
    int scoreToDisplay = widget.overrideScore ??
        (widget.isTeamOne
            ? widget.ongoingState?.teamOne.score ?? 0
            : widget.ongoingState?.teamTwo.score ?? 0);

    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: ExtendedText(
        text: scoreToDisplay.toString(),
        userState: widget.userState,
        fontSize: 40,
        isBold: true,
      ),
    );
  }
}
