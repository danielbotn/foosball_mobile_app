import 'package:flutter/material.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class OrgnisationScreen extends StatelessWidget {
  final UserState userState;
  const OrgnisationScreen({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: userState.hardcodedStrings.organisation,
                userState: userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(userState.darkmode),
            backgroundColor: helpers.getBackgroundColor(userState.darkmode)),
        body: Container(
          color: userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white,
          child: Column(
            children: [
              Card(
                color: userState.darkmode
                    ? AppColors.darkModeBackground
                    : AppColors.white,
                child: ListTile(
                    leading: Icon(Icons.house_siding_rounded,
                        color: userState.darkmode ? AppColors.white : null),
                    title: ExtendedText(
                        text: userState.hardcodedStrings.currentOrganisation,
                        userState: userState),
                    subtitle: ExtendedText(
                        text: userState.userInfoGlobal.currentOrganisationName,
                        userState: userState)),
              ),
              const Divider()
            ],
          ),
        ));
  }
}
