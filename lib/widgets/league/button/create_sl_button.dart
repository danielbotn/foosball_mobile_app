import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeaguePlayersApi.dart';
import 'package:foosball_mobile_app/models/single-league-players/single_league_players_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class CreateSingleLeagueButton extends StatelessWidget {
  final UserState userState;
  final List<UserResponse> selectedPlayersList;
  final int leagueId;
  const CreateSingleLeagueButton(
      {super.key,
      required this.userState,
      required this.selectedPlayersList,
      required this.leagueId});

  @override
  Widget build(BuildContext context) {
    void addSingleLeaguePlayers() async {
      SingleLeaguePlayersApi api = SingleLeaguePlayersApi();
      SingleLeaguePlayersModel singleLeaguePlayersModel =
          SingleLeaguePlayersModel(
              users: selectedPlayersList, leagueId: leagueId);
      bool result = await api.addSingleLeaguePlayers(singleLeaguePlayersModel);

      if (result) {
        // success
      } else {
        // failure
      }
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {addSingleLeaguePlayers()},
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: const Text('start league'),
              ),
            )),
      ],
    );
  }
}
