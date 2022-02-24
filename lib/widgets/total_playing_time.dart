import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'extended_Text.dart';

class TotalPlayingTime extends StatelessWidget {
  final UserState userState;
  final String totalPlayingTimeLabel;
  final String totalPlayingTime;
  const TotalPlayingTime(
      {Key? key,
      required this.userState,
      required this.totalPlayingTime,
      required this.totalPlayingTimeLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.timer,
                    color: this.userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack),
                title: ExtendedText(
                    text: totalPlayingTimeLabel, userState: this.userState),
                subtitle: ExtendedText(
                    text: this.totalPlayingTime, userState: this.userState),
              ),
            ),
          ],
        ));
  }
}
