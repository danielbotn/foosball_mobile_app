import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/DoubleLeaguePlayersApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/double-league-players/double_league_player_model.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/league/add_double_league_teams/add_team_button.dart';
import 'package:foosball_mobile_app/widgets/league/add_double_league_teams/team_overview.dart';
import 'package:foosball_mobile_app/widgets/league/add_double_league_teams/teams_selecter.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class AddDoubleLeagueTeams extends StatefulWidget {
  final UserState userState;
  final GetLeagueResponse leagueData;
  const AddDoubleLeagueTeams(
      {super.key, required this.userState, required this.leagueData});

  @override
  State<AddDoubleLeagueTeams> createState() => _AddDoubleLeagueTeamsState();
}

class _AddDoubleLeagueTeamsState extends State<AddDoubleLeagueTeams> {
  // State
  late Future<List<DoubleLeaguePlayerModel>?> playersFuture;
  List<UserResponse> selectedPlayers = [];
  List<DoubleLeaguePlayerModel> leaguePlayers = [];

  // function
  void teamReady(List<UserResponse> teamPlayers) async {
    setState(() {
      selectedPlayers = teamPlayers;
    });

    var tmp = await getLeaguePlayers();
  }

  Future<List<DoubleLeaguePlayerModel>?> getLeaguePlayers() async {
    DoubleLeaguePlayersApi api = DoubleLeaguePlayersApi();
    var allPlayers = await api.getDoubleLeaguePlayers(widget.leagueData.id);
    if (allPlayers != null) {
      setState(() {
        leaguePlayers = allPlayers;
      });
    }
    return allPlayers;
  }

  @override
  void initState() {
    super.initState();
    playersFuture = getLeaguePlayers();
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    bool darkMode = widget.userState.darkmode;
    return Scaffold(
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
          title: ExtendedText(
            text: "Add Teams",
            userState: widget.userState,
            colorOverride: widget.userState.darkmode
                ? AppColors.white
                : AppColors.textBlack,
          ),
        ),
        body: FutureBuilder<List<DoubleLeaguePlayerModel>?>(
          future: playersFuture,
          builder: (BuildContext context,
              AsyncSnapshot<List<DoubleLeaguePlayerModel>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Loading(
                    userState: widget
                        .userState), // Show a loading indicator while waiting for the future to complete
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                    'Error: ${snapshot.error}'), // Show an error message if the future encountered an error
              );
            } else {
              List<DoubleLeaguePlayerModel>? players = snapshot.data;
              return Theme(
                data: darkMode ? ThemeData.dark() : ThemeData.light(),
                child: Column(
                  children: <Widget>[
                    TeamsSelecter(userState: userState, addTeam: teamReady),
                    TeamOverview(userState: userState, team: selectedPlayers),
                    const Spacer(),
                    AddTeamButton(userState: userState),
                  ],
                ),
              );
            }
          },
        ));
  }
}
