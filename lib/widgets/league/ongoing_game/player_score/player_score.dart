import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class PlayerScore extends StatefulWidget {
  final UserState userState;
  final int score;
  const PlayerScore({super.key, required this.userState, required this.score});

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 90),
        child: ExtendedText(
          text: widget.score.toString(),
          userState: widget.userState,
          fontSize: 40,
          isBold: true,
        ));
  }
}
