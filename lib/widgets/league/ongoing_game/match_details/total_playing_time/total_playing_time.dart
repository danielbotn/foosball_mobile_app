import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

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
                    color: userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack),
                title: ExtendedText(
                    text: totalPlayingTimeLabel, userState: userState),
                subtitle:
                    ExtendedText(text: totalPlayingTime, userState: userState),
              ),
            ),
          ],
        ));
  }
}
