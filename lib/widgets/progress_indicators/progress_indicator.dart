import 'package:flutter/material.dart';
import 'dart:async';

import 'package:foosball_mobile_app/state/user_state.dart';

typedef MyFormCallback = void Function(bool result);

class LeagueProgressIndicator extends StatefulWidget {
  final UserState userState;
  final MyFormCallback isTimerDone;
  const LeagueProgressIndicator(
      {super.key, required this.userState, required this.isTimerDone});

  @override
  State<LeagueProgressIndicator> createState() =>
      _LeagueProgressIndicatorState();
}

class _LeagueProgressIndicatorState extends State<LeagueProgressIndicator> {
  double _progressValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_progressValue == 1.0) {
          widget.isTimerDone(true);
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _progressValue += 0.25;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            value: _progressValue,
          ),
          const SizedBox(height: 10),
          Text('${(_progressValue * 100).toInt()}%'),
        ],
      ),
    );
  }
}
