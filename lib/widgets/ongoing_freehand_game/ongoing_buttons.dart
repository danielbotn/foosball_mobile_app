import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class OngoingButtons extends StatefulWidget {
  final OngoingFreehandState counter;
  final Function() notifyParent;
  final UserState userState;
  OngoingButtons(
      {Key? key,
      required this.counter,
      required this.notifyParent,
      required this.userState})
      : super(key: key);

  @override
  State<OngoingButtons> createState() => _OngoingButtonsState();
}

class _OngoingButtonsState extends State<OngoingButtons> {
  @override
  Widget build(BuildContext context) {
    void clockIsPaused() {
      this.widget.counter.setIsClockPaused(!widget.counter.isClockPaused);
      widget.notifyParent();
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
              child: Container(
                child: ElevatedButton(
                  onPressed: () => {clockIsPaused()},
                  child: Text(widget.counter.isClockPaused
                      ? widget.userState.hardcodedStrings.resume
                      : widget.userState.hardcodedStrings.pause),
                ),
              ),
            )),
      ],
    );
  }
}
