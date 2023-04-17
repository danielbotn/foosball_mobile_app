import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeaguePlayersApi.dart';
import 'package:foosball_mobile_app/models/single-league-players/single_league_players_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/league/single_league_overview/single_league_overview.dart';
import 'package:foosball_mobile_app/widgets/progress_indicators/progress_indicator.dart';

class CreateSingleLeagueButton extends StatefulWidget {
  final UserState userState;
  final List<UserResponse> selectedPlayersList;
  final int leagueId;
  const CreateSingleLeagueButton(
      {super.key,
      required this.userState,
      required this.selectedPlayersList,
      required this.leagueId});

  @override
  State<CreateSingleLeagueButton> createState() =>
      _CreateSingleLeagueButtonState();
}

class _CreateSingleLeagueButtonState extends State<CreateSingleLeagueButton> {
  bool showProgressBar = false;

  void isTimerDone(bool isDone) {
    setState(() {
      showProgressBar = !isDone;
    });
    // Here I want to go to new screen
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleLeagueOverview(
                  userState: widget.userState,
                  leagueId: widget.leagueId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    void addSingleLeaguePlayers() async {
      SingleLeaguePlayersApi api = SingleLeaguePlayersApi();
      SingleLeaguePlayersModel singleLeaguePlayersModel =
          SingleLeaguePlayersModel(
              users: widget.selectedPlayersList, leagueId: widget.leagueId);
      bool result = await api.addSingleLeaguePlayers(singleLeaguePlayersModel);

      if (result) {
        setState(() {
          showProgressBar = true;
        });
      } else {
        // failure
      }
    }

    if (showProgressBar) {
      return LeagueProgressIndicator(
          userState: widget.userState, isTimerDone: isTimerDone);
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {addSingleLeaguePlayers()},
                style: ElevatedButton.styleFrom(
                  primary: widget.userState.darkmode
                      ? AppColors.lightThemeShadowColor
                      : AppColors.buttonsLightTheme,
                  minimumSize: const Size(100, 50),
                ),
                child: const Text('start league'),
              ),
            ),
          ),
        ],
      );
    }
  }
}
