import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/single_league/button/SingleLeagueButton.dart';

class SingleLeagueDashboard extends StatefulWidget {
  final UserState userState;
  const SingleLeagueDashboard({Key? key, required this.userState})
      : super(key: key);

  @override
  State<SingleLeagueDashboard> createState() => _SingleLeagueDashboardState();
}

class _SingleLeagueDashboardState extends State<SingleLeagueDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.userState.darkmode
          ? AppColors.darkModeBackground
          : AppColors.white,
      child: Column(
        children: <Widget>[
          ExtendedText(
            text: 'Current Leagues',
            userState: widget.userState,
            fontSize: 20,
          ),
          const Spacer(),
          SingleLeagueButton(userState: userState)
        ],
      ),
    );
  }
}
