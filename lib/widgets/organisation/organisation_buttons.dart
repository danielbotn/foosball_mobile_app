import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/group_players/create_group_player.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import 'new_organisation.dart';

class OrganisationButtons extends StatefulWidget {
  final UserState userState;
  final Function() notifyOrganisation;
  const OrganisationButtons(
      {Key? key, required this.userState, required this.notifyOrganisation})
      : super(key: key);

  @override
  State<OrganisationButtons> createState() => _OrganisationButtonsState();
}

class _OrganisationButtonsState extends State<OrganisationButtons> {
  void notifyOrganisation() {
    widget.notifyOrganisation();
  }

  @override
  Widget build(BuildContext context) {
    goToCreateGroupUser(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateGroupPlayer(
                    userState: widget.userState,
                    // to do
                  )));
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewOrganisation(
                                userState: widget.userState,
                                notifyOrganisationButtons: notifyOrganisation,
                              )))
                },
                style: ElevatedButton.styleFrom(
                    primary: widget.userState.darkmode
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: ExtendedText(
                  userState: widget.userState,
                  text: widget.userState.hardcodedStrings.newOrganisation,
                  colorOverride: AppColors.white,
                ),
              ),
            )),
        Visibility(
          visible: widget.userState.currentOrganisationId != 0,
          child: Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () => {goToCreateGroupUser(context)},
                  style: ElevatedButton.styleFrom(
                      primary: widget.userState.darkmode
                          ? AppColors.darkModeButtonColor
                          : AppColors.buttonsLightTheme,
                      minimumSize: const Size(100, 50)),
                  child: ExtendedText(
                    userState: widget.userState,
                    text: widget.userState.hardcodedStrings.addPlayers,
                    colorOverride: AppColors.white,
                  ),
                ),
              )),
        )
      ],
    );
  }
}
