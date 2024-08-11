import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class MatchScore extends StatelessWidget {
  final UserState userState;
  final String userScore;

  const MatchScore({
    Key? key,
    required this.userState,
    required this.userScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    ExtendedText(
                      text: userScore,
                      userState: userState,
                      fontSize: 40,
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
