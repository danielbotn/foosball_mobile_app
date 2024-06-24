import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/models/leagues/double-league-standings-model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/UI/Error/ServerError.dart';
import 'package:foosball_mobile_app/widgets/league/single_league_standings/table_cell_standings.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class DoubleLeagueStandings extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  const DoubleLeagueStandings(
      {super.key, required this.userState, required this.leagueId});

  @override
  State<DoubleLeagueStandings> createState() => _DoubleLeagueStandingsState();
}

class _DoubleLeagueStandingsState extends State<DoubleLeagueStandings> {
  Future<List<DoubleLeagueStandingsModel>?>? standingsFuture;

  @override
  void initState() {
    super.initState();
    standingsFuture = LeagueApi().geDoubleLeagueStandings(widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    Helpers helpers = Helpers();
    return FutureBuilder<List<DoubleLeagueStandingsModel>?>(
      future: standingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Loading(
              userState: widget.userState,
            ),
          );
        } else if (snapshot.hasError) {
          return ServerError(userState: widget.userState);
        } else if (snapshot.hasData) {
          final standings = snapshot.data!;

          return Container(
              height: double.infinity,
              color: helpers.getBackgroundColor(widget.userState.darkmode),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(5),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1),
                  6: FlexColumnWidth(1),
                  7: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: darkMode
                          ? AppColors.darkModeBackground
                          : Colors.grey[400],
                      border: Border.all(),
                    ),
                    children: [
                      TableCellStandings(
                          userState: widget.userState, text: 'PI'),
                      TableCellStandings(
                          userState: widget.userState, text: 'Name'),
                      TableCellStandings(
                          userState: widget.userState, text: 'W'),
                      TableCellStandings(
                          userState: widget.userState, text: 'L'),
                      TableCellStandings(
                          userState: widget.userState, text: '+/-'),
                      TableCellStandings(
                          userState: widget.userState, text: 'Pts'),
                    ],
                  ),
                  for (int i = 0; i < standings.length; i++)
                    TableRow(
                      decoration: BoxDecoration(
                        color: i % 2 == 0
                            ? darkMode
                                ? AppColors.leagueDarkModeColorOne
                                : Colors.grey[300]
                            : darkMode
                                ? AppColors.leagueDarkModeColorTwo
                                : Colors.white,
                      ),
                      children: [
                        TableCellStandings(
                            userState: widget.userState,
                            text: standings[i].positionInLeague.toString()),
                        TableCellStandings(
                            userState: widget.userState,
                            text: standings[i].teamName),
                        TableCellStandings(
                            userState: widget.userState,
                            text: standings[i].totalMatchesWon.toString()),
                        TableCellStandings(
                            userState: widget.userState,
                            text: standings[i].totalMatchesLost.toString()),
                        TableCellStandings(
                            userState: widget.userState,
                            text:
                                '${standings[i].totalGoalsScored - standings[i].totalGoalsRecieved}'),
                        TableCellStandings(
                            userState: widget.userState,
                            text: standings[i].points.toString()),
                      ],
                    ),
                ],
              ));
        } else {
          return Container();
        }
      },
    );
  }
}
