import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

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
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: ExtendedText(
                  userState: widget.userState,
                  text: widget.userState.hardcodedStrings.newOrganisation,
                  colorOverride: AppColors.white,
                ),
              ),
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    primary: widget.userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: ExtendedText(
                  userState: widget.userState,
                  text: widget.userState.hardcodedStrings.addPlayers,
                  colorOverride: AppColors.white,
                ),
              ),
            )),
      ],
    );
  }
}
