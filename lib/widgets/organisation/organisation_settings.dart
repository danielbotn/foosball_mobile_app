import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/widgets/organisation/join_organisation.dart';
import 'package:foosball_mobile_app/widgets/organisation/new_organisation.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import 'organisation_code.dart';

class OrganisationSettings extends StatelessWidget {
  final UserState userState;
  const OrganisationSettings({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    goToOrganisationCode(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrganisationCode(
                    userState: userState,
                  )));
    }

    goToNewOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewOrganisation(
                    userState: userState,
                    // to do
                    notifyOrganisationButtons: () {},
                  )));
    }

    goToJoinOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JoinOrganisation(
                    userState: userState,
                    // to do
                  )));
    }

    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: userState.hardcodedStrings.organisationSettings,
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
            child: Theme(
                data: userState.darkmode ? ThemeData.dark() : ThemeData.light(),
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: Text(
                        userState.hardcodedStrings.actions,
                      ),
                      tiles: [
                        SettingsTile(
                          title: Text(
                              userState.hardcodedStrings.createNewOrganisation),
                          leading: const Icon(Icons.add_circle_outline_sharp),
                          onPressed: (BuildContext context) {
                            goToNewOrganisation(context);
                          },
                        ),
                        SettingsTile(
                          title: Text(userState
                              .hardcodedStrings.joinExistingOrganisation),
                          leading: const Icon(Icons.account_box),
                          onPressed: (BuildContext context) {
                            goToJoinOrganisation(context);
                          },
                        ),
                        SettingsTile(
                          title: Text(userState.hardcodedStrings.managePlayers),
                          leading: const Icon(Icons.person),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text(
                              userState.hardcodedStrings.changeOrganisation),
                          leading: const Icon(Icons.change_circle),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                    // person section
                    SettingsSection(
                      title: Text(userState.hardcodedStrings.information),
                      tiles: [
                        SettingsTile(
                          title:
                              Text(userState.hardcodedStrings.organisationCode),
                          description: Text(userState.hardcodedStrings
                              .letOtherPlayersJoinYourOrganisation),
                          leading: const Icon(Icons.qr_code),
                          onPressed: (BuildContext context) {
                            goToOrganisationCode(context);
                          },
                        ),
                      ],
                    ),
                    // integrations
                    SettingsSection(
                      title: Text(userState.hardcodedStrings.integration),
                      tiles: [
                        SettingsTile(
                          title: Text(userState.hardcodedStrings.slack),
                          description: const Text(
                              "https://hooks.slack.com/services/T0J5QJQQP/B0J5QJQQQ/0J5QJQQQQ"),
                          leading: const Icon(Icons.abc),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text(userState.hardcodedStrings.discord),
                          description: const Text(
                              "https://hooks.discord.com/services/T0J5QJQQP/B0J5QJQQQ/0J5QJQQQQ"),
                          leading: const Icon(Icons.discord),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
