import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/models/leagues/single-league-standings-model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/league/single_league_standings/table_cell_standings.dart';

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
    return FutureBuilder<List<SingleLeagueStandingsModel>?>(
      future: standingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching standings.'),
          );
        } else if (snapshot.hasData) {
          final standings = snapshot.data!;

          return Table(
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
                  color: Colors.grey[200],
                  border: Border.all(),
                ),
                children: [
                  TableCellStandings(userState: widget.userState, text: 'PI'),
                  TableCellStandings(userState: widget.userState, text: 'Name'),
                  TableCellStandings(userState: widget.userState, text: 'W'),
                  TableCellStandings(userState: widget.userState, text: 'L'),
                  TableCellStandings(userState: widget.userState, text: '+/-'),
                  TableCellStandings(userState: widget.userState, text: 'Pts'),
                ],
              ),
              for (int i = 0; i < standings.length; i++)
                TableRow(
                  decoration: BoxDecoration(
                    color: i % 2 == 0 ? Colors.white : Colors.grey[200],
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
