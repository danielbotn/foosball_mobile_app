import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/icons/custom_icons.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';
import 'package:dano_foosball/widgets/Settings/DiscordSettings.dart';
import 'package:dano_foosball/widgets/Settings/MicrosoftTeamsSettings.dart';
import 'package:dano_foosball/widgets/Settings/SlackSettings.dart';
import 'package:dano_foosball/widgets/group_players/create_group_player.dart';
import 'package:dano_foosball/widgets/organisation/change_organisation.dart';
import 'package:dano_foosball/widgets/organisation/join_organisation.dart';
import 'package:dano_foosball/widgets/organisation/new_organisation.dart';
import 'package:dano_foosball/widgets/organisation/organisation_manage_players.dart';
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
  late Future<UserResponse> userFuture;
  late Future<OrganisationResponse?>? organisationFuture;

  @override
  void initState() {
    super.initState();
    userFuture = getUser();
    if (widget.userState.currentOrganisationId != 0) {
      organisationFuture = getOrganisation();
    } else {
      organisationFuture = Future.value(null);
    }
  }

  Future<UserResponse> getUser() async {
    UserApi user = UserApi();
    return await user.getUser(widget.userState.userId.toString());
  }

  Future<OrganisationResponse?> getOrganisation() async {
    Organisation api = Organisation();
    return await api.getOrganisationById(
      widget.userState.currentOrganisationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.organisationSettings,
          userState: widget.userState,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
      ),
      body: FutureBuilder(
        future: Future.wait([userFuture, organisationFuture!]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(userState: widget.userState);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userData = snapshot.data![0] as UserResponse;
            final organisationData = snapshot.data![1] as OrganisationResponse?;

            return Container(
              color: widget.userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              child: Theme(
                data: widget.userState.darkmode
                    ? ThemeData.dark()
                    : ThemeData.light(),
                child: buildSettingsList(userData, organisationData),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  SettingsList buildSettingsList(
    UserResponse userData,
    OrganisationResponse? organisationData,
  ) {
    List<SettingsSection> sections = [];

    sections.add(
      SettingsSection(
        title: Text(widget.userState.hardcodedStrings.actions),
        tiles: _setTiles(userData),
      ),
    );

    if (widget.userState.currentOrganisationId != 0) {
      sections.add(
        SettingsSection(
          title: Text(widget.userState.hardcodedStrings.information),
          tiles: _setInformationTiles(),
        ),
      );

      sections.add(
        SettingsSection(
          title: Text(widget.userState.hardcodedStrings.integration),
          tiles: _setIntegrationTiles(organisationData),
        ),
      );
    }

    return SettingsList(sections: sections);
  }

  List<AbstractSettingsTile> _setTiles(UserResponse userData) {
    List<AbstractSettingsTile> result = [
      SettingsTile(
        title: Text(widget.userState.hardcodedStrings.createNewOrganisation),
        leading: const Icon(Icons.add_circle_outline_sharp),
        onPressed: (_) => _goToNewOrganisation(),
      ),
      SettingsTile(
        title: Text(widget.userState.hardcodedStrings.joinExistingOrganisation),
        leading: const Icon(Icons.group_add),
        onPressed: (_) => _goToJoinOrganisation(),
      ),
    ];

    if (widget.userState.currentOrganisationId != 0) {
      result.add(
        SettingsTile(
          title: Text(widget.userState.hardcodedStrings.changeOrganisation),
          leading: const Icon(Icons.change_circle),
          onPressed: (_) => _goToChangeOrganisation(),
        ),
      );

      result.add(
        SettingsTile(
          title: Text(widget.userState.hardcodedStrings.createGroupPlayer),
          leading: const Icon(Icons.emoji_people),
          onPressed: (_) => _goToCreateGroupUser(),
        ),
      );
    }

    if (userData.isAdmin == true) {
      result.add(
        SettingsTile(
          title: Text(widget.userState.hardcodedStrings.managePlayers),
          leading: const Icon(Icons.person),
          onPressed: (_) => _goToManagePlayers(),
        ),
      );
    }

    return result;
  }

  List<AbstractSettingsTile> _setInformationTiles() {
    return [
      SettingsTile(
        title: Text(widget.userState.hardcodedStrings.organisationCode),
        description: Text(
          widget.userState.hardcodedStrings.letOtherPlayersJoinYourOrganisation,
        ),
        leading: const Icon(Icons.qr_code),
        onPressed: (_) => _goToOrganisationCode(),
      ),
    ];
  }

  List<AbstractSettingsTile> _setIntegrationTiles(
    OrganisationResponse? organisation,
  ) {
    return [
      SettingsTile(
        title: Text(widget.userState.hardcodedStrings.slack),
        description: Text(organisation?.slackWebhookUrl ?? ""),
        leading: const Icon(CustomIcons.slack),
        onPressed: (_) => _goToChangeSlackWebHook(),
      ),
      SettingsTile(
        title: Text(widget.userState.hardcodedStrings.discord),
        description: Text(organisation?.discordWebhookUrl ?? ""),
        leading: const Icon(CustomIcons.discord),
        onPressed: (_) => _goToChangeDiscordWebHook(),
      ),
      SettingsTile(
        title: const Text("Microsoft Teams"),
        description: Text(organisation?.microsoftTeamsWebhookUrl ?? ""),
        leading: const Icon(Icons.window),
        onPressed: (_) => _goToChangeTeamsWebHook(),
      ),
    ];
  }

  void _goToOrganisationCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrganisationCode(userState: widget.userState),
      ),
    );
  }

  void _goToNewOrganisation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewOrganisation(
          userState: widget.userState,
          notifyOrganisationButtons: () {},
        ),
      ),
    );
  }

  void _goToJoinOrganisation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoinOrganisation(userState: widget.userState),
      ),
    );
  }

  void _goToChangeOrganisation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeOrganisation(userState: widget.userState),
      ),
    );
  }

  void _goToCreateGroupUser() {
    if (widget.userState.currentOrganisationId != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroupPlayer(userState: widget.userState),
        ),
      );
    }
  }

  void _goToManagePlayers() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrganisationManagePlayers(userState: widget.userState),
      ),
    );
  }

  void _goToChangeSlackWebHook() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SlackSettings(userState: widget.userState),
      ),
    ).then((_) {
      setState(() {
        organisationFuture = getOrganisation();
      });
    });
  }

  void _goToChangeDiscordWebHook() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscordSettings(userState: widget.userState),
      ),
    ).then((_) {
      setState(() {
        organisationFuture = getOrganisation();
      });
    });
  }

  void _goToChangeTeamsWebHook() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamsSettings(userState: widget.userState),
      ),
    ).then((_) {
      setState(() {
        organisationFuture = getOrganisation();
      });
    });
  }
}
