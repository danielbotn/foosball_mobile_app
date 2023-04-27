import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class OngoingGameButton extends StatefulWidget {
  final UserState userState;
  final bool gameStarted;
  const OngoingGameButton(
      {super.key, required this.userState, required this.gameStarted});

  @override
  State<OngoingGameButton> createState() => _OngoingGameButtonState();
}

class _OngoingGameButtonState extends State<OngoingGameButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {},
                child: Text(widget.gameStarted == false
                    ? widget.userState.hardcodedStrings.startGame
                    : widget.userState.hardcodedStrings.pause),
              ),
            )),
      ],
    );
  }
}
