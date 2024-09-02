import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class PlayerScore extends StatelessWidget {
  final UserState userState;
  final int score;

  const PlayerScore({
    super.key,
    required this.userState,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: ExtendedText(
        text: score.toString(),
        userState: userState,
        fontSize: 40,
        isBold: true,
      ),
    );
  }
}
