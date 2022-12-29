import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import 'organisation_settings.dart';

class OrganisationCard extends StatelessWidget {
  final UserState userState;
  final Function() notifyParent;
  const OrganisationCard(
      {Key? key, required this.userState, required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          userState.darkmode ? AppColors.darkModeBackground : AppColors.white,
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.home_work_rounded,
            color: userState.darkmode ? Colors.white : Colors.grey),
        title: ExtendedText(
          text: userState.hardcodedStrings.currentOrganisation,
          userState: userState,
        ),
        subtitle: ExtendedText(
          text: userState.userInfoGlobal.currentOrganisationName,
          userState: userState,
        ),
        trailing: IconButton(
          icon: Icon(Icons.settings,
              color: userState.darkmode ? Colors.white : Colors.grey),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrganisationSettings(
                          userState: userState,
                        ))).then((value) {
              notifyParent();
            });
          },
        ),
      ),
    );
  }
}
