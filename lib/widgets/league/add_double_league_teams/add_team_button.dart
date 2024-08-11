import 'package:flutter/material.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/create_double_league_team.dart';

class AddTeamButton extends StatefulWidget {
  final UserState userState;
  final List<UserResponse> teamPlayers;
  final int leagueId;

  const AddTeamButton({
    Key? key,
    required this.userState,
    required this.teamPlayers,
    required this.leagueId,
  }) : super(key: key);

  @override
  State<AddTeamButton> createState() => _AddTeamButtonState();
}

class _AddTeamButtonState extends State<AddTeamButton> {
  void addTeam() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDoubleLeagueTeam(
          userState: widget.userState,
          teamPlayers: widget.teamPlayers,
          leagueId: widget.leagueId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: addTeam,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: widget.userState.hardcodedStrings.addTeam,
                userState: widget.userState,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
