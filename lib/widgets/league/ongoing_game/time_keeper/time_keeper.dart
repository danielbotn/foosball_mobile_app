import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class TimeKeeper extends StatefulWidget {
  final UserState userState;
  final Duration duration;
  const TimeKeeper(
      {super.key, required this.userState, required this.duration});

  @override
  State<TimeKeeper> createState() => _TimeKeeperState();
}

class _TimeKeeperState extends State<TimeKeeper> {
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(widget.duration.inHours.remainder(60));
    final minutes = twoDigits(widget.duration.inMinutes.remainder(60));
    final seconds = twoDigits(widget.duration.inSeconds.remainder(60));
    final hoursString = hours != '00' ? '$hours:' : '';
    return Column(
      children: [
        ListTile(
          tileColor: helpers.getBackgroundColor(widget.userState.darkmode),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ExtendedText(
                text: '$hoursString$minutes:$seconds',
                userState: widget.userState,
                fontSize: 22,
                isBold: true,
              ),
            ],
          ),
          leading: SizedBox(
            height: 100,
            width: 50,
            child: Icon(Icons.watch_later_outlined,
                color: widget.userState.darkmode ? AppColors.white : null),
          ),
        )
      ],
    );
  }
}
