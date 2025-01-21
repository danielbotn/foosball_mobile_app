import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/add_double_league_teams.dart';
import 'package:dano_foosball/widgets/league/add_league_players/add_league_players.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/league/button/LeagueButton.dart';
import 'package:dano_foosball/widgets/league/dashbaord/LeagueDashboard.dart';
import 'package:tuple/tuple.dart';

class League extends StatefulWidget {
  final UserState userState;
  const League({super.key, required this.userState});

  @override
  State<League> createState() => _LeagueState();
}

class _LeagueState extends State<League> {
  // state
  String randomNumber = "";
  bool showButton = true;

  void goToAddDoubleLeagueTeams(GetLeagueResponse leagueData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddDoubleLeagueTeams(
                  userState: widget.userState,
                  leagueData: leagueData,
                )));
  }

  void goToAddSingleLeaguePlayers(GetLeagueResponse leagueData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddLeaguePlayers(
                  userState: widget.userState,
                  leagueData: leagueData,
                )));
  }

  void updateLeagueList(Tuple2<bool, GetLeagueResponse?> result) {
    Helpers helpers = Helpers();
    setState(() {
      randomNumber = helpers.generateRandomString();
    });
    // test
    if (result.item2 != null) {
      GetLeagueResponse tmp = GetLeagueResponse(
        id: result.item2!.id,
        name: result.item2!.name,
        typeOfLeague: result.item2!.typeOfLeague,
        createdAt: result.item2!.createdAt,
        organisationId: result.item2!.organisationId,
        upTo: result.item2!.upTo,
        hasLeagueStarted: result.item2!.hasLeagueStarted,
        howManyRounds: result.item2!.howManyRounds,
      );
      if (result.item2!.typeOfLeague == 0) {
        goToAddSingleLeaguePlayers(tmp);
      }

      if (result.item2!.typeOfLeague == 1) {
        goToAddDoubleLeagueTeams(tmp);
      }
    }
  }

  void hideButton() {
    setState(() {
      showButton = !showButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    Helpers helpers = Helpers();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.league,
          userState: widget.userState,
          colorOverride:
              widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
        ),
      ),
      body: Theme(
        data: darkMode ? ThemeData.dark() : ThemeData.light(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LeagueDashboard(
              userState: widget.userState,
              randomNumber: randomNumber,
            ),
            Visibility(
              visible:
                  showButton && widget.userState.currentOrganisationId != 0,
              child: LeagueButton(
                userState: widget.userState,
                newLeaugeCreated: updateLeagueList,
                hideButton: hideButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
