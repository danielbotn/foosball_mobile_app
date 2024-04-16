import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/widgets/group_players/create_group_player.dart';
import 'package:foosball_mobile_app/widgets/organisation/change_organisation.dart';
import 'package:foosball_mobile_app/widgets/organisation/join_organisation.dart';
import 'package:foosball_mobile_app/widgets/organisation/new_organisation.dart';
import 'package:foosball_mobile_app/widgets/organisation/organisation_manage_players.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../api/UserApi.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import '../loading.dart';
import 'organisation_code.dart';

class OrganisationSettings extends StatefulWidget {
  final UserState userState;
  const OrganisationSettings({Key? key, required this.userState})
      : super(key: key);

  @override
  State<OrganisationSettings> createState() => _OrganisationSettingsState();
}

class _OrganisationSettingsState extends State<OrganisationSettings> {
  // state
  late Future<UserResponse> userFuture;
  late UserResponse playersData;

  @override
  void initState() {
    super.initState();
    userFuture = getUser();
  }

  Future<UserResponse> getUser() async {
    UserApi user = UserApi();
    var data = await user.getUser(widget.userState.userId.toString());
    playersData = data;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    goToOrganisationCode(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrganisationCode(
                    userState: widget.userState,
                  )));
    }

    goToNewOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewOrganisation(
                    userState: widget.userState,
                    // to do
                    notifyOrganisationButtons: () {},
                  )));
    }

    goToJoinOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JoinOrganisation(
                    userState: widget.userState,
                    // to do
                  )));
    }

    goToManagePlayers(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrganisationManagePlayers(
                    userState: widget.userState,
                    // to do
                  )));
    }

    goToChangeOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeOrganisation(
                    userState: widget.userState,
                    // to do
                  )));
    }

    goToCreateGroupUser(BuildContext context) {
      if (widget.userState.currentOrganisationId != 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateGroupPlayer(
                      userState: widget.userState,
                      // to do
                    )));
      }
    }

    List<AbstractSettingsTile> setTiles(UserResponse userData) {
      List<AbstractSettingsTile> result = [
        SettingsTile(
          title: Text(widget.userState.hardcodedStrings.createNewOrganisation),
          leading: const Icon(Icons.add_circle_outline_sharp),
          onPressed: (BuildContext context) {
            goToNewOrganisation(context);
          },
        ),
        SettingsTile(
          title:
              Text(widget.userState.hardcodedStrings.joinExistingOrganisation),
          leading: const Icon(Icons.add_circle_outline_sharp),
          onPressed: (BuildContext context) {
            goToJoinOrganisation(context);
          },
        ),
      ];

      if (widget.userState.currentOrganisationId != 0) {
        result.add(SettingsTile(
          title: Text(widget.userState.hardcodedStrings.changeOrganisation),
          leading: const Icon(Icons.change_circle),
          onPressed: (BuildContext context) {
            goToChangeOrganisation(context);
          },
        ));

        result.add(SettingsTile(
          title: Text(widget.userState.hardcodedStrings.createGroupPlayer),
          leading: const Icon(Icons.emoji_people),
          onPressed: (BuildContext context) {
            goToCreateGroupUser(context);
          },
        ));
      }

      if (userData.isAdmin != null && userData.isAdmin == true) {
        result.add(SettingsTile(
          title: Text(widget.userState.hardcodedStrings.managePlayers),
          leading: const Icon(Icons.person),
          onPressed: (BuildContext context) {
            goToManagePlayers(context);
          },
        ));
      }

      return result;
    }

    List<AbstractSettingsTile> setInformationTiles() {
      List<AbstractSettingsTile> result = [];

      if (widget.userState.currentOrganisationId != 0) {
        result.add(SettingsTile(
          title: Text(widget.userState.hardcodedStrings.organisationCode),
          description: Text(widget
              .userState.hardcodedStrings.letOtherPlayersJoinYourOrganisation),
          leading: const Icon(Icons.qr_code),
          onPressed: (BuildContext context) {
            goToOrganisationCode(context);
          },
        ));
      }

      return result;
    }

    SettingsList buildSettingsList(UserResponse userData) {
      List<SettingsSection> sections = [];

      // Actions section
      sections.add(SettingsSection(
        title: Text(widget.userState.hardcodedStrings.actions),
        tiles: setTiles(userData),
      ));

      // Information section
      if (widget.userState.currentOrganisationId != 0) {
        sections.add(SettingsSection(
          title: Text(widget.userState.hardcodedStrings.information),
          tiles: setInformationTiles(),
        ));
      }

      // Integrations section
      if (widget.userState.currentOrganisationId != 0) {
        sections.add(SettingsSection(
          title: Text(widget.userState.hardcodedStrings.integration),
          tiles: [
            SettingsTile(
              title: Text(widget.userState.hardcodedStrings.slack),
              description: const Text(
                  "https://hooks.slack.com/services/T0J5QJQQP/B0J5QJQQQ/0J5QJQQQQ"),
              leading: const Icon(Icons.abc),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: Text(widget.userState.hardcodedStrings.discord),
              description: const Text(
                  "https://hooks.discord.com/services/T0J5QJQQP/B0J5QJQQQ/0J5QJQQQQ"),
              leading: const Icon(Icons.discord),
              onPressed: (BuildContext context) {},
            ),
          ],
        ));
      }

      return SettingsList(sections: sections);
    }

    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.organisationSettings,
                userState: widget.userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(widget.userState.darkmode),
            backgroundColor:
                helpers.getBackgroundColor(widget.userState.darkmode)),
        body: FutureBuilder(
          future: userFuture,
          builder: (context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data as UserResponse;
              return Container(
                  color: widget.userState.darkmode
                      ? AppColors.darkModeBackground
                      : AppColors.white,
                  child: Theme(
                    data: widget.userState.darkmode
                        ? ThemeData.dark()
                        : ThemeData.light(),
                    child: buildSettingsList(userData),
                  ));
            } else {
              return Loading(
                userState: widget.userState,
              );
            }
          },
        ));
  }
}
