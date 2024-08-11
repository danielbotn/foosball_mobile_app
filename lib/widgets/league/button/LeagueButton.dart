import 'package:flutter/material.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/league/dialogs/create_new_league_dialog.dart';

class LeagueButton extends StatefulWidget {
  final UserState userState;
  final Function() newLeaugeCreated;
  final Function() hideButton;

  const LeagueButton({
    Key? key,
    required this.userState,
    required this.newLeaugeCreated,
    required this.hideButton,
  }) : super(key: key);

  @override
  State<LeagueButton> createState() => _LeagueButtonState();
}

class _LeagueButtonState extends State<LeagueButton> {
  void onSubmit(bool createdLeagueSuccessful) {
    if (createdLeagueSuccessful == true) {
      widget.newLeaugeCreated();
    }
    widget.hideButton();
  }

  void onCancel(bool val) {
    widget.hideButton();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.userState.darkmode
          ? AppColors
              .darkModeBackground // Replace with your desired dark mode background color
          : AppColors
              .white, // Replace with your desired light mode background color
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: () {
                widget.hideButton();
                showDialog(
                  context: context,
                  builder: (context) => CreateLeagueDialog(
                    onSubmit: onSubmit,
                    onCancel: onCancel,
                    userState: widget.userState,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.userState.darkmode
                    ? AppColors
                        .darkModeButtonColor // Replace with your dark mode button color
                    : AppColors
                        .buttonsLightTheme, // Replace with your light mode button color
                minimumSize: const Size(100, 50),
              ),
              child: Text(widget.userState.hardcodedStrings.createNewLeague),
            ),
          ),
        ],
      ),
    );
  }
}
