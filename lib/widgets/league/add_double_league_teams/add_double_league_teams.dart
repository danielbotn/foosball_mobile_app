import 'package:flutter/material.dart';
import 'package:dano_foosball/api/DoubleLeagueMatchApi.dart';
import 'package:dano_foosball/api/DoubleLeaguePlayersApi.dart';
import 'package:dano_foosball/api/LeagueApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/double-league-players/double_league_player_model.dart';
import 'package:dano_foosball/models/leagues/create-league-body.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/headline.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/add_team_button.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/team_overview.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/teams_selecter.dart';
import 'package:dano_foosball/widgets/league/double_league_overview/double_league_overview.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:dano_foosball/widgets/progress_indicators/progress_indicator.dart';

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
  int totalTeams = 0;
  bool showProgressBar = false;

  // function
  void teamReady(List<UserResponse> teamPlayers) async {
    setState(() {
      selectedPlayers = teamPlayers;
    });

    var tmp = await getLeaguePlayers();
  }

  bool checkIfUserIsInLeague() {
    bool result = false;

    for (var element in leaguePlayers) {
      if (userState.userId == element.userId) {
        result = true;
        break;
      }
    }
    return result;
  }

  void goToLeagueOverview() {
    final navigator = Navigator.of(context);
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => NewDashboard(userState: widget.userState),
        ),
        (route) => false);

    // Push the DoubleLeagueOverview screen
    navigator.push(MaterialPageRoute(
      builder: (context) => DoubleLeagueOverview(
        userState: widget.userState,
        leagueData: widget.leagueData,
      ),
    ));
  }

  void isTimerDone(bool isDone) {
    setState(() {
      showProgressBar = !isDone;
    });
    // Here I want to go to new screen
    goToLeagueOverview();
  }

  void startLeague() async {
    try {
      if (checkIfUserIsInLeague() == false) {
        Helpers helpers = Helpers();
        helpers.showSnackbar(
            context, userState.hardcodedStrings.partOfLeagueToStartIt, true);
        return;
      }
      DoubleLeagueMatchApi api = DoubleLeagueMatchApi();
      LeagueApi lApi = LeagueApi();
      CreateLeagueBody body = CreateLeagueBody(
          name: widget.leagueData.name,
          typeOfLeague: widget.leagueData.typeOfLeague,
          upTo: widget.leagueData.upTo,
          organisationId: widget.leagueData.organisationId,
          howManyRounds: widget.leagueData.howManyRounds,
          hasLeagueStarted: true);
      var updateSuccessful =
          await lApi.updateLeague(widget.leagueData.id, body);

      var createMatches =
          await api.createDoubleLeagueMatches(widget.leagueData.id);

      if (updateSuccessful && createMatches!.isNotEmpty) {
        // Push the /dashboard screen and remove all previous routes from the stack
        setState(() {
          showProgressBar = true;
        });
      } else {
        // Handle unsuccessful update
      }
    } on Exception catch (_) {
      Helpers helpers = Helpers();
      helpers.showSnackbar(
          context, userState.hardcodedStrings.startLeagueError, true);
    }
  }

  Future<List<DoubleLeaguePlayerModel>?> getLeaguePlayers() async {
    DoubleLeaguePlayersApi api = DoubleLeaguePlayersApi();
    var allPlayers = await api.getDoubleLeaguePlayers(widget.leagueData.id);
    if (allPlayers != null && allPlayers.isNotEmpty) {
      setState(() {
        leaguePlayers = allPlayers;
      });
      if (allPlayers.length > 3) {
        setState(() {
          totalTeams = allPlayers.length ~/ 2;
        });
      }
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
            text: widget.userState.hardcodedStrings.addTeam,
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
              return ServerError(userState: widget.userState);
            } else {
              return Container(
                color: darkMode
                    ? AppColors.darkModeLighterBackground
                    : AppColors.white,
                child: Column(
                  children: <Widget>[
                    TeamsSelecter(userState: userState, addTeam: teamReady),
                    Visibility(
                      visible: selectedPlayers.isNotEmpty,
                      child: Headline(
                          headline: userState.hardcodedStrings.selectedPlayers,
                          userState: userState),
                    ),
                    TeamOverview(userState: userState, team: selectedPlayers),
                    const Spacer(),
                    Visibility(
                      visible: totalTeams >= 2,
                      child: ExtendedText(
                        text:
                            '${userState.hardcodedStrings.totalTeamsInLeague} $totalTeams',
                        userState: userState,
                      ),
                    ),
                    Visibility(
                      visible: selectedPlayers.length >= 2,
                      child: AddTeamButton(
                        userState: userState,
                        teamPlayers: selectedPlayers,
                        leagueId: widget.leagueData.id,
                      ),
                    ),
                    Visibility(
                        visible: showProgressBar == true,
                        child: LeagueProgressIndicator(
                            userState: widget.userState,
                            isTimerDone: isTimerDone)),
                    Visibility(
                      visible: totalTeams >= 2 && showProgressBar == false,
                      child: Button(
                          userState: userState,
                          onClick: startLeague,
                          text: userState.hardcodedStrings.startLeague,
                          paddingBottom: 4,
                          paddingLeft: 4,
                          paddingRight: 4,
                          paddingTop: 10),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
