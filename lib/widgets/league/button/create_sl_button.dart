import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/SingleLeagueMatchApi.dart';
import 'package:dano_foosball/api/SingleLeaguePlayersApi.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/models/single-league-players/single_league_players_model.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/league/single_league_overview/single_league_overview.dart';
import 'package:dano_foosball/widgets/progress_indicators/progress_indicator.dart';

class CreateSingleLeagueButton extends StatefulWidget {
  final UserState userState;
  final List<UserResponse> selectedPlayersList;
  final GetLeagueResponse leagueData;

  const CreateSingleLeagueButton({
    super.key,
    required this.userState,
    required this.selectedPlayersList,
    required this.leagueData,
  });

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
    // Navigate to the new screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleLeagueOverview(
          userState: widget.userState,
          leagueData: widget.leagueData,
          leagueNewlyCreated: true,
        ),
      ),
    );
  }

  Future<void> addSingleLeaguePlayers() async {
    SingleLeaguePlayersApi api = SingleLeaguePlayersApi();
    SingleLeagueMatchApi slmapi = SingleLeagueMatchApi();
    SingleLeaguePlayersModel singleLeaguePlayersModel =
        SingleLeaguePlayersModel(
      users: widget.selectedPlayersList,
      leagueId: widget.leagueData.id,
    );

    bool result = await api.addSingleLeaguePlayers(singleLeaguePlayersModel);
    var matches = await slmapi.createSingleLeagueMatches(widget.leagueData.id);

    if (result && matches!.isNotEmpty) {
      setState(() {
        showProgressBar = true;
      });
    } else {
      // Handle failure
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showProgressBar) {
      return LeagueProgressIndicator(
        userState: widget.userState,
        isTimerDone: isTimerDone,
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: addSingleLeaguePlayers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.userState.darkmode
                      ? AppColors.darkModeButtonColor
                      : AppColors.buttonsLightTheme,
                  minimumSize: const Size(100, 50),
                ),
                child: ExtendedText(
                  text: widget.userState.hardcodedStrings.startLeague,
                  userState: widget.userState,
                  colorOverride: AppColors.white,
                  fontSize: 14,
                  isBold: true,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
