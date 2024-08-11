import 'package:flutter/material.dart';
import 'package:dano_foosball/api/LeagueApi.dart';
import 'package:dano_foosball/models/leagues/single-league-standings-model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/league/single_league_standings/table_cell_standings.dart';
import 'package:dano_foosball/widgets/loading.dart';

class SingleLeagueStandings extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  const SingleLeagueStandings(
      {super.key, required this.userState, required this.leagueId});

  @override
  State<SingleLeagueStandings> createState() => _SingleLeagueStandingsState();
}

class _SingleLeagueStandingsState extends State<SingleLeagueStandings> {
  Future<List<SingleLeagueStandingsModel>?>? standingsFuture;

  @override
  void initState() {
    super.initState();
    standingsFuture = LeagueApi().getSingleLeagueStandings(widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    Helpers helpers = Helpers();
    return FutureBuilder<List<SingleLeagueStandingsModel>?>(
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
                            text:
                                "${standings[i].firstName} ${standings[i].lastName}"),
                        TableCellStandings(
                            userState: widget.userState,
                            text: '${standings[i].totalMatchesWon}'),
                        TableCellStandings(
                            userState: widget.userState,
                            text: '${standings[i].totalMatchesLost}'),
                        TableCellStandings(
                            userState: widget.userState,
                            text:
                                '${standings[i].totalGoalsScored - standings[i].totalGoalsRecieved}'),
                        TableCellStandings(
                            userState: widget.userState,
                            text: '${standings[i].points}'),
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
