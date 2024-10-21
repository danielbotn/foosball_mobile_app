import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/league/dialogs/create_new_league_dialog.dart';

class LeagueButton extends StatefulWidget {
  final UserState userState;
  final Function() newLeaugeCreated;
  final Function() hideButton;

  const LeagueButton({
    super.key,
    required this.userState,
    required this.newLeaugeCreated,
    required this.hideButton,
  });

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
          ? AppColors.darkModeBackground
          : AppColors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: () {
                widget.hideButton();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                      ),
                      child: CreateLeagueDialog(
                        onSubmit: onSubmit,
                        onCancel: onCancel,
                        userState: widget.userState,
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: widget.userState.hardcodedStrings.createNewLeague,
                userState: userState,
                colorOverride: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
