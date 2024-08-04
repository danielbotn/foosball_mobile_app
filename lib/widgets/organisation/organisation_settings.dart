import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/icons/custom_icons.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/widgets/Settings/DiscordSettings.dart';
import 'package:foosball_mobile_app/widgets/Settings/MicrosoftTeamsSettings.dart';
import 'package:foosball_mobile_app/widgets/Settings/SlackSettings.dart';
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
  late Future<OrganisationResponse?> organisationFuture;

  @override
  void initState() {
    super.initState();
    userFuture = getUser();
    organisationFuture = getOrganisation();
  }

  Future<UserResponse> getUser() async {
    UserApi user = UserApi();
    var data = await user.getUser(widget.userState.userId.toString());
    playersData = data;
    return data;
  }

  Future<OrganisationResponse?> getOrganisation() async {
    Organisation api = Organisation();
    var data =
        await api.getOrganisationById(widget.userState.currentOrganisationId);
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
                    notifyOrganisationButtons: () {},
                  )));
    }

    goToJoinOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JoinOrganisation(
                    userState: widget.userState,
                  )));
    }

    goToManagePlayers(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrganisationManagePlayers(
                    userState: widget.userState,
                  )));
    }

    goToChangeOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeOrganisation(
                    userState: widget.userState,
                  )));
    }

    goToCreateGroupUser(BuildContext context) {
      if (widget.userState.currentOrganisationId != 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateGroupPlayer(
                      userState: widget.userState,
                    )));
      }
    }

    goToChangeSlackWebHook(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SlackSettings(
            userState: widget.userState,
          ),
        ),
      ).then((_) {
        // Fetch new organisation data when coming back from SlackSettings
        setState(() {
          organisationFuture = getOrganisation();
        });
      });
    }

    goToChangeDiscordWebHook(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiscordSettings(
            userState: widget.userState,
          ),
        ),
      ).then((_) {
        // Fetch new organisation data when coming back from SlackSettings
        setState(() {
          organisationFuture = getOrganisation();
        });
      });
    }

    goToChangeTeamsWebHook(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeamsSettings(
            userState: widget.userState,
          ),
        ),
      ).then((_) {
        // Fetch new organisation data when coming back from SlackSettings
        setState(() {
          organisationFuture = getOrganisation();
        });
      });
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

    List<AbstractSettingsTile> setIntegrationTiles(
        OrganisationResponse? organisation) {
      return [
        SettingsTile(
          title: Text(widget.userState.hardcodedStrings.slack),
          description: Text(organisation?.slackWebhookUrl ?? ""),
          leading: const Icon(CustomIcons.slack),
          onPressed: (BuildContext context) {
            goToChangeSlackWebHook(context);
          },
        ),
        SettingsTile(
          title: Text(widget.userState.hardcodedStrings.discord),
          description: Text(organisation?.discordWebhookUrl ?? ""),
          leading: const Icon(CustomIcons.discord),
          onPressed: (BuildContext context) {
            goToChangeDiscordWebHook(context);
          },
        ),
        SettingsTile(
          title: const Text("Microsoft Teams"),
          description: Text(organisation?.microsoftTeamsWebhookUrl ?? ""),
          leading: const Icon(Icons.window),
          onPressed: (BuildContext context) {
            goToChangeTeamsWebHook(context);
          },
        ),
      ];
    }

    SettingsList buildSettingsList(
        UserResponse userData, OrganisationResponse? organisationData) {
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
          tiles: setIntegrationTiles(organisationData),
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
          future: Future.wait([userFuture, organisationFuture]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading(
                userState: widget.userState,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              var userData = snapshot.data![0] as UserResponse;
              var organisationData = snapshot.data![1] as OrganisationResponse?;

              return Container(
                  color: widget.userState.darkmode
                      ? AppColors.darkModeBackground
                      : AppColors.white,
                  child: Theme(
                    data: widget.userState.darkmode
                        ? ThemeData.dark()
                        : ThemeData.light(),
                    child: buildSettingsList(userData, organisationData),
                  ));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ));
  }
}
