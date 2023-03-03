import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/single_league/dashbaord/SingleLeagueDashboard.dart';

class League extends StatefulWidget {
  final UserState userState;
  const League({Key? key, required this.userState}) : super(key: key);

  @override
  State<League> createState() => _LeagueState();
}

class _LeagueState extends State<League> {
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helpers.getIconTheme(widget.userState.darkmode),
          backgroundColor:
              helpers.getBackgroundColor(widget.userState.darkmode),
          bottom: TabBar(
            labelColor:
                userState.darkmode ? AppColors.white : AppColors.textBlack,
            tabs: const [
              Tab(text: 'Single League'),
              Tab(text: 'Team League'),
            ],
          ),
          title: ExtendedText(
            text: 'League',
            userState: userState,
            colorOverride:
                userState.darkmode ? AppColors.white : AppColors.textBlack,
          ),
        ),
        body: TabBarView(
          children: [
            SingleLeagueDashboard(userState: userState),
            Icon(
              Icons.directions_bike,
              color: userState.darkmode ? AppColors.white : AppColors.textBlack,
            ),
          ],
        ),
      ),
    );
  }
}
