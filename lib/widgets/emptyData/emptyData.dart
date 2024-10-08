import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';

class EmptyData extends StatelessWidget {
  final UserState userState;
  final String message;
  final IconData iconData;

  const EmptyData(
      {Key? key,
      required this.userState,
      required this.message,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Container(
      color: helpers.getBackgroundColor(userState.darkmode),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: userState.darkmode ? AppColors.white : null,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: userState.darkmode ? AppColors.white : null,
            ),
          ),
          if (userState.currentOrganisationId ==
              0) // Additional message for currentOrganisationId == 0
            Text(
              userState.hardcodedStrings.noOrganisation,
              style: TextStyle(
                fontSize: 14,
                color: userState.darkmode ? AppColors.white : null,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
