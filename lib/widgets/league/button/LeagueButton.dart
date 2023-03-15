import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/league/dialogs/create_new_league_dialog.dart';

class LeagueButton extends StatefulWidget {
  final UserState userState;
  final Function() newLeaugeCreated;
  final Function() hideButton;
  const LeagueButton(
      {Key? key,
      required this.userState,
      required this.newLeaugeCreated,
      required this.hideButton})
      : super(key: key);

  @override
  State<LeagueButton> createState() => _LeagueButtonState();
}

enum SingleOrDouble { single, double }

class _LeagueButtonState extends State<LeagueButton> {
  void onSubmit(bool createdLeagueSuccessfull) {
    if (createdLeagueSuccessfull == true) {
      widget.newLeaugeCreated();
    }
    widget.hideButton();
  }

  void onCancel(bool val) {
    widget.hideButton();
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
                onPressed: () => {
                  widget.hideButton(),
                  showDialog(
                      context: context,
                      builder: (context) => CreateLeagueDialog(
                            onSubmit: onSubmit,
                            onCancel: onCancel,
                            userState: widget.userState,
                          )),
                },
                style: ElevatedButton.styleFrom(
                    primary: widget.userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: Text(userState.hardcodedStrings.createNewLeague),
              ),
            )),
      ],
    );
  }
}
