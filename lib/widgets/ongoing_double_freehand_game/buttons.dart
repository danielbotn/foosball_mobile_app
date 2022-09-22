import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/ongoing_double_freehand_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class Buttons extends StatefulWidget {
  final OngoingDoubleFreehandState ongoingState;
  final Function() notifyParent;
  final UserState userState;
  const Buttons(
      {Key? key,
      required this.ongoingState,
      required this.notifyParent,
      required this.userState})
      : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    void clockIsPaused() {
      widget.ongoingState.setIsClockPaused(!widget.ongoingState.isClockPaused);
      widget.notifyParent();
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
              child: ElevatedButton(
                onPressed: () => {clockIsPaused()},
                child: Text(widget.ongoingState.isClockPaused
                    ? widget.userState.hardcodedStrings.resume
                    : widget.userState.hardcodedStrings.pause),
              ),
            )),
      ],
    );
  }
}
