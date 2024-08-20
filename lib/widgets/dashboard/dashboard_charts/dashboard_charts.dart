import 'package:flutter/material.dart';
import 'package:dano_foosball/api/UserApi.dart';
import 'package:dano_foosball/models/charts/user_stats_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/dashboard/dashboard_goals_chart.dart';
import 'package:dano_foosball/widgets/dashboard/dashboard_matches_chart.dart';
import 'package:dano_foosball/widgets/loading.dart';

Future<UserStatsResponse> getUserStatsData(
    int userId, int currentOrganisationId) async {
  UserApi user = UserApi();
  var userStatsData = await user.getUserStats();
  return userStatsData;
}

class DashboardCharts extends StatefulWidget {
  final UserState userState;
  const DashboardCharts({super.key, required this.userState});

  @override
  State<DashboardCharts> createState() => _DashboardChartsState();
}

class _DashboardChartsState extends State<DashboardCharts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserStatsResponse>(
      future: getUserStatsData(
          widget.userState.userId, widget.userState.currentOrganisationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Loading(
            userState: widget.userState,
          ));
        } else if (snapshot.hasError) {
          return ServerError(userState: widget.userState);
        } else if (snapshot.hasData) {
          // Use the user stats data here
          return Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 200,
                    child: DashboardMatchesChart(
                      userState: widget.userState,
                      userStatsResponse: snapshot.data,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 200,
                    child: DashboardGoalsChart(
                        userState: widget.userState,
                        userStatsResponse: snapshot.data),
                  )),
            ],
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
