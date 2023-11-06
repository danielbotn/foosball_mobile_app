import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/DoubleLeaguePlayersApi.dart';
import 'package:foosball_mobile_app/api/DoubleLeagueTeams.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/models/double-league-players/double_league_player_create_body.dart';
import 'package:foosball_mobile_app/models/double-league-teams/createDoubleLeagueTeamBody.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/UI/Buttons/Button.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/inputs/InputWidget.dart';
import 'package:foosball_mobile_app/widgets/league/add_double_league_teams/add_double_league_teams.dart';
import 'package:foosball_mobile_app/widgets/league/add_double_league_teams/team_overview.dart';

class CreateDoubleLeagueTeam extends StatefulWidget {
  final UserState userState;
  final List<UserResponse> teamPlayers;
  final int leagueId;
  const CreateDoubleLeagueTeam(
      {super.key,
      required this.userState,
      required this.teamPlayers,
      required this.leagueId});

  @override
  State<CreateDoubleLeagueTeam> createState() => _CreateDoubleLeagueTeamState();
}

class _CreateDoubleLeagueTeamState extends State<CreateDoubleLeagueTeam> {
  // state
  String inputName = "";

  void onChangeInput(String value) {
    setState(() {
      inputName = value;
    });
  }

  void onButtonClick() async {
    final navigator = Navigator.of(context);
    try {
      if (inputName.isNotEmpty) {
        DoubleLeagueTeamsApi api = DoubleLeagueTeamsApi();
        CreateDoubleLeagueTeamBody body = CreateDoubleLeagueTeamBody(
            leagueId: widget.leagueId, name: inputName);
        var team = await api.createDoubleLeagueTeam(body);

        DoubleLeaguePlayersApi dpAPI = DoubleLeaguePlayersApi();

        DoubleLeaguePlayerCreateBody dlpcbody = DoubleLeaguePlayerCreateBody(
            userOneId: widget.teamPlayers[0].id,
            userTwoId: widget.teamPlayers[1].id,
            teamId: team!.id);
        var createdPlayers = await dpAPI.createDoubleLeaguePlayer(dlpcbody);

        if (createdPlayers!.insertionSuccessfull) {
          // Remove the last screen from the stack
          navigator.pop();

          // Push the new screen onto the stack
          LeagueApi lapi = LeagueApi();
          var leagueData = await lapi.getLeagueById(widget.leagueId);
          if (leagueData != null) {
            navigator.push(MaterialPageRoute(
              builder: (context) => AddDoubleLeagueTeams(
                userState: widget.userState,
                leagueData: leagueData,
              ),
            ));
          }
        }
      }
    } on Exception catch (_) {
      Helpers helpers = Helpers();
      helpers.showSnackbar(
          context, "Error occurred. Could not create a new team", true);
    }
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
            text: "Create Team",
            userState: widget.userState,
            colorOverride: widget.userState.darkmode
                ? AppColors.white
                : AppColors.textBlack,
          ),
        ),
        body: Theme(
          data: darkMode ? ThemeData.dark() : ThemeData.light(),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputWidget(
                      userState: widget.userState,
                      onChangeInput: onChangeInput,
                      clearInputText: false,
                      hintText: "Team Name")),
              TeamOverview(
                  userState: widget.userState, team: widget.teamPlayers),
              const Spacer(),
              Button(
                  userState: widget.userState,
                  onClick: onButtonClick,
                  text: 'Create Team',
                  paddingBottom: 4,
                  paddingLeft: 4,
                  paddingRight: 4,
                  paddingTop: 10),
            ],
          ),
        ));
  }
}
