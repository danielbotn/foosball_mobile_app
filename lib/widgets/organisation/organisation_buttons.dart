import 'package:flutter/material.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/group_players/create_group_player.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import 'new_organisation.dart';

class OrganisationButtons extends StatefulWidget {
  final UserState userState;
  final Function() notifyOrganisation;

  const OrganisationButtons({
    Key? key,
    required this.userState,
    required this.notifyOrganisation,
  }) : super(key: key);

  @override
  State<OrganisationButtons> createState() => _OrganisationButtonsState();
}

class _OrganisationButtonsState extends State<OrganisationButtons> {
  void _notifyOrganisation() {
    widget.notifyOrganisation();
  }

  void _goToCreateGroupUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGroupPlayer(
          userState: widget.userState,
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
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewOrganisation(
                      userState: widget.userState,
                      notifyOrganisationButtons: _notifyOrganisation,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                userState: widget.userState,
                text: widget.userState.hardcodedStrings.newOrganisation,
                colorOverride: AppColors.white,
                isBold: true,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.userState.currentOrganisationId != 0,
          child: Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _goToCreateGroupUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.userState.darkmode
                      ? AppColors.darkModeButtonColor
                      : AppColors.buttonsLightTheme,
                  minimumSize: const Size(100, 50),
                ),
                child: ExtendedText(
                  userState: widget.userState,
                  text: widget.userState.hardcodedStrings.addPlayers,
                  colorOverride: AppColors.white,
                  isBold: true,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
