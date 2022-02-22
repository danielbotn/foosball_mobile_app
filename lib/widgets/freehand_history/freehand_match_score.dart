import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import '../extended_Text.dart';

class FreehandMatchScore extends StatelessWidget {
  final UserState userState;
  final String userScore;

  const FreehandMatchScore({
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
                      userState: this.userState,
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
