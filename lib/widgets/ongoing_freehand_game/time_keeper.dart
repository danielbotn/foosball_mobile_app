import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dano_foosball/models/other/ongoing_game_object.dart';
import 'package:dano_foosball/state/ongoing_freehand_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import '../extended_Text.dart';

class TimeKeeper extends StatefulWidget {
  final OngoingGameObject ongoingGameObject;
  final OngoingFreehandState counter;
  final String randomString;
  final String randomStringStopClock;
  const TimeKeeper(
      {Key? key,
      required this.ongoingGameObject,
      required this.counter,
      required this.randomString,
      required this.randomStringStopClock})
      : super(key: key);

  @override
  State<TimeKeeper> createState() => _TimeKeeperState();
}

class _TimeKeeperState extends State<TimeKeeper> {
  Duration duration = new Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didUpdateWidget(TimeKeeper oldWidget) {
    if (widget.counter.isClockPaused) {
      stopTimer(resets: false);
    } else {
      if (oldWidget.randomString != widget.randomString) {
        startTimer(resets: false);
      }
    }

    if (oldWidget.randomStringStopClock != widget.randomStringStopClock) {
      stopTimer(resets: false);
    }
    super.didUpdateWidget(oldWidget);
  }

  void addTime() {
    final addSeconds = 1;
    final seconds = duration.inSeconds + addSeconds;
    setState(() {
      duration = Duration(seconds: seconds);
    });
    // add total seconds to state mangagment
    widget.counter.setElapsedSeconds(seconds);
  }

  void reset() {
    setState(() => duration = Duration());
    widget.counter.setElapsedSeconds(0);
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(new Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = false}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hoursString = hours != '00' ? '$hours:' : '';

    Helpers helpers = Helpers();
    return Observer(builder: (_) {
      return Column(
        children: [
          ListTile(
            tileColor: helpers.getBackgroundColor(
                widget.ongoingGameObject.userState.darkmode),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExtendedText(
                  text: '$hoursString$minutes:$seconds',
                  userState: this.widget.ongoingGameObject.userState,
                  fontSize: 22,
                  isBold: true,
                ),
              ],
            ),
            leading: SizedBox(
              height: 100,
              width: 50,
              child: Icon(Icons.watch_later_outlined,
                  color: widget.ongoingGameObject.userState.darkmode
                      ? AppColors.white
                      : null),
            ),
          )
        ],
      );
    });
  }
}
