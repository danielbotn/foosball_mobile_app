import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class AddTeamButton extends StatefulWidget {
  final UserState userState;
  const AddTeamButton({super.key, required this.userState});

  @override
  State<AddTeamButton> createState() => _AddTeamButtonState();
}

class _AddTeamButtonState extends State<AddTeamButton> {
  void addTeam() async {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () => {addTeam()},
              style: ElevatedButton.styleFrom(
                primary: widget.userState.darkmode
                    ? AppColors.lightThemeShadowColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: const Text('Add Team'),
            ),
          ),
        ),
      ],
    );
  }
}
