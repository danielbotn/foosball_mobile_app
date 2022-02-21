import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class FreehandMatchTotalPlayingTime extends StatelessWidget {
  final UserState userState;
  final String totalPlayingTimeLabel;
  final String totalPlayingTime;
  const FreehandMatchTotalPlayingTime(
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
                leading: Icon(Icons.timer, color: this.userState.darkmode ? AppColors.white : AppColors.textBlack),
                title: Text(totalPlayingTimeLabel,
                    style: TextStyle(
                        color: this.userState.darkmode
                            ? AppColors.white
                            : AppColors.textBlack)),
                subtitle: Text(this.totalPlayingTime,
                    style: TextStyle(
                        color: this.userState.darkmode
                            ? AppColors.white
                            : AppColors.textGrey)),
              ),
            ),
          ],
        ));
  }
}
