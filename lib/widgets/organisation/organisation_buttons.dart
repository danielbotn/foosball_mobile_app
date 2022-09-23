import 'package:flutter/material.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';

class OrganisationButtons extends StatefulWidget {
  final UserState userState;
  const OrganisationButtons({Key? key, required this.userState})
      : super(key: key);

  @override
  State<OrganisationButtons> createState() => _OrganisationButtonsState();
}

class _OrganisationButtonsState extends State<OrganisationButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
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
                child: Text(widget.userState.hardcodedStrings.newOrganisation),
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
                child: Text(widget.userState.hardcodedStrings.addPlayers),
              ),
            )),
      ],
    );
  }
}
