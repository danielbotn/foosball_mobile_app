import 'package:dano_foosball/widgets/Settings/ChangeUserInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// Custom imports
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/preferences_service.dart';
import 'package:dano_foosball/icons/custom_icons.dart';
import 'package:dano_foosball/widgets/loading.dart';

// API and Model imports
import 'package:dano_foosball/api/Dato_CMS.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/models/cms/hardcoded_strings.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';

// Settings page imports
import 'package:dano_foosball/widgets/Settings/DiscordSettings.dart';
import 'package:dano_foosball/widgets/Settings/MicrosoftTeamsSettings.dart';
import 'package:dano_foosball/widgets/Settings/SlackSettings.dart';
import 'package:dano_foosball/widgets/change_password/ChangePassword.dart';
import 'package:dano_foosball/widgets/organisation/organisation.dart'
    as orgWidget;

class Settings extends StatefulWidget {
  final UserState userState;
  const Settings({super.key, required this.userState});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with RouteAware {
  var selectedLanguage = "";
  bool isSwitched = false;
  var isDarkTheme;

  late Future<HardcodedStrings?> hardcodedStringsFuture;
  late Future<OrganisationResponse?> organisationFuture;

  @override
  void initState() {
    super.initState();
    setSelectedLanguage(widget.userState.language);
    hardcodedStringsFuture = getHardcodedStrings(widget.userState.language);
    organisationFuture = getOrganisation();
  }

  Future<OrganisationResponse?> getOrganisation() async {
    Organisation api = Organisation();
    var data =
        await api.getOrganisationById(widget.userState.currentOrganisationId);
    return data;
  }

  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    DatoCMS datoCMS = DatoCMS();
    var hardcodedStrings = await datoCMS.getHardcodedStrings(language);
    return hardcodedStrings;
  }

  void setSelectedLanguage(String language) {
    String result = "";

    if (language == 'is') {
      result = 'Íslenska';
    } else if (language == 'en') {
      result = 'English';
    } else {
      result = 'Svenska';
    }

    setState(() {
      selectedLanguage = result;
    });
  }

  Future<void> changeTheme(bool value) async {
    PreferencesService preferencesService = PreferencesService();
    await preferencesService.setDarkTheme(value);
    setState(() {
      isSwitched = value;
    });
    widget.userState.setDarkmode(value);
  }

  void changeHardcodedStrings(String language) {
    hardcodedStringsFuture = getHardcodedStrings(language);

    hardcodedStringsFuture.then((value) {
      if (value != null) {
        widget.userState.setHardcodedStrings(value);
      }
    });
  }

  Future<void> setLanguage(String value) async {
    PreferencesService preferencesService = PreferencesService();
    await preferencesService.setLanguage(value);
    setSelectedLanguage(value);
    widget.userState.setLanguage(value);
    changeHardcodedStrings(value);
  }

  void goToChangeUserInformation(BuildContext context) {
    var screen = ChangeUserInfoScreen(userState: widget.userState);

    navigateToPage(
      screen,
      context,
    );
  }

  void goToOrganisationSettings(BuildContext context) {
    var organisationWidget =
        orgWidget.OrganisationScreen(userState: widget.userState);

    navigateToPage(
      organisationWidget,
      context,
    );
  }

  Future<void> selectLanguagePopup(BuildContext context) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select language'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'English'),
                child: const Text('English'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'Icelandic'),
                child: const Text('Íslenska'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'Swedish'),
                child: const Text('Svenska'),
              ),
            ],
          );
        })) {
      case 'English':
        await setLanguage('en');
        break;
      case 'Icelandic':
        await setLanguage('is');
        break;
      case 'Swedish':
        await setLanguage('sv');
        break;
    }
  }

  void navigateToPage(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ).then((_) {
      setState(() {
        organisationFuture = getOrganisation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, widget.userState),
        ),
        iconTheme: widget.userState.darkmode
            ? const IconThemeData(color: AppColors.white)
            : IconThemeData(color: Colors.grey[700]),
        backgroundColor: widget.userState.darkmode
            ? AppColors.darkModeBackground
            : AppColors.white,
      ),
      body: FutureBuilder(
        future: Future.wait([hardcodedStringsFuture, organisationFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var hardcodedStrings = snapshot.data?[0] as HardcodedStrings?;
            var organisation = snapshot.data?[1] as OrganisationResponse?;
            return Theme(
              data: widget.userState.darkmode
                  ? ThemeData.dark()
                  : ThemeData.light(),
              child: SettingsList(
                sections: [
                  _buildCommonSection(hardcodedStrings),
                  _buildPersonalInfoSection(hardcodedStrings),
                  _buildIntegrationSection(organisation, hardcodedStrings),
                  _buildSecuritySection(hardcodedStrings),
                ],
              ),
            );
          } else {
            return Center(
              child: Loading(userState: widget.userState),
            );
          }
        },
      ),
    );
  }

  SettingsSection _buildCommonSection(HardcodedStrings? hardcodedStrings) {
    return SettingsSection(
      title: ExtendedText(
        text: hardcodedStrings?.common ?? "Common",
        userState: widget.userState,
        fontSize: 14,
      ),
      tiles: [
        SettingsTile(
          title: ExtendedText(
            text: hardcodedStrings?.language ?? "Language",
            userState: widget.userState,
            fontSize: 14,
          ),
          trailing: ExtendedText(
            text: selectedLanguage,
            userState: widget.userState,
            fontSize: 14,
          ),
          leading: const Icon(Icons.language),
          onPressed: (BuildContext context) => selectLanguagePopup(context),
        ),
        SettingsTile.switchTile(
          title: ExtendedText(
            text: widget.userState.darkmode
                ? hardcodedStrings?.darkTheme ?? "Dark Theme"
                : hardcodedStrings?.lightTheme ?? "Light Theme",
            userState: widget.userState,
            fontSize: 14,
          ),
          leading: const Icon(Icons.phone_android),
          initialValue: widget.userState.darkmode,
          onToggle: changeTheme,
        ),
      ],
    );
  }

  SettingsTile buildSettingsTile({
    required String title,
    required String description,
    required IconData leadingIcon,
    required UserState userState,
    VoidCallback? onPressed,
  }) {
    return SettingsTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtendedText(
            text: title,
            userState: userState,
            fontSize: 14,
          ),
          SizedBox(height: 4), // Adds a small gap between title and description
          ExtendedText(
            text: description,
            userState: userState,
            fontSize: 12,
          ),
        ],
      ),
      leading: Icon(leadingIcon),
      onPressed: (BuildContext context) {
        if (onPressed != null) onPressed();
      },
    );
  }

  SettingsSection _buildPersonalInfoSection(
      HardcodedStrings? hardcodedStrings) {
    return SettingsSection(
      title: ExtendedText(
        text: hardcodedStrings?.personalInformation ?? "Personal Information",
        userState: widget.userState,
        fontSize: 14,
      ),
      tiles: [
        buildSettingsTile(
          title: hardcodedStrings?.username ?? "Username",
          description: widget.userState.userInfoGlobal.email,
          leadingIcon: Icons.email,
          userState: widget.userState,
          onPressed: () => selectLanguagePopup(context),
        ),
        buildSettingsTile(
          title: hardcodedStrings?.user ?? "User",
          description:
              "${widget.userState.userInfoGlobal.firstName} ${widget.userState.userInfoGlobal.lastName}",
          leadingIcon: Icons.person,
          userState: widget.userState,
          onPressed: () => goToChangeUserInformation(context),
        ),
        buildSettingsTile(
          title: hardcodedStrings?.organisation ?? "Organisation",
          description: widget.userState.userInfoGlobal.currentOrganisationName,
          leadingIcon: Icons.business,
          userState: widget.userState,
          onPressed: () => goToOrganisationSettings(context),
        ),
      ],
    );
  }

  SettingsSection _buildIntegrationSection(
      OrganisationResponse? organisation, HardcodedStrings? hardcodedStrings) {
    return SettingsSection(
      title: ExtendedText(
        text: hardcodedStrings?.integration ?? "Integration",
        userState: widget.userState,
        fontSize: 14,
      ),
      tiles: [
        SettingsTile(
          title: ExtendedText(
            text: hardcodedStrings?.slack ?? "Slack",
            userState: widget.userState,
            fontSize: 14,
          ),
          description: ExtendedText(
            text: organisation?.slackWebhookUrl ?? "",
            userState: widget.userState,
            fontSize: 12,
          ),
          leading: const Icon(CustomIcons.slack),
          onPressed: (BuildContext context) => navigateToPage(
            SlackSettings(userState: widget.userState),
            context,
          ),
        ),
        SettingsTile(
          title: ExtendedText(
            text: hardcodedStrings?.discord ?? "Discord",
            userState: widget.userState,
            fontSize: 14,
          ),
          description: ExtendedText(
            text: organisation?.discordWebhookUrl ?? "",
            userState: widget.userState,
            fontSize: 12,
          ),
          leading: const Icon(CustomIcons.discord),
          onPressed: (BuildContext context) => navigateToPage(
            DiscordSettings(userState: widget.userState),
            context,
          ),
        ),
        SettingsTile(
          title: ExtendedText(
            text: "Microsoft Teams",
            userState: widget.userState,
            fontSize: 14,
          ),
          description: ExtendedText(
            text: organisation?.microsoftTeamsWebhookUrl ?? "",
            userState: widget.userState,
            fontSize: 12,
          ),
          leading: const Icon(Icons.window),
          onPressed: (BuildContext context) => navigateToPage(
            TeamsSettings(userState: widget.userState),
            context,
          ),
        ),
      ],
    );
  }

  SettingsSection _buildSecuritySection(HardcodedStrings? hardcodedStrings) {
    return SettingsSection(
      title: ExtendedText(
        text: hardcodedStrings?.security ?? "Security",
        userState: widget.userState,
        fontSize: 14,
      ),
      tiles: [
        SettingsTile(
          title: ExtendedText(
            text: hardcodedStrings?.changePassword ?? "Change Password",
            userState: widget.userState,
            fontSize: 14,
          ),
          leading: const Icon(Icons.lock),
          onPressed: (BuildContext context) => navigateToPage(
            ChangePassword(userState: widget.userState),
            context,
          ),
        ),
        SettingsTile.switchTile(
          title: ExtendedText(
            text:
                hardcodedStrings?.enableNotifications ?? "Enable Notifications",
            userState: widget.userState,
            fontSize: 14,
          ),
          enabled: false,
          leading: const Icon(Icons.notifications_active),
          initialValue: true,
          onToggle: (value) {},
        ),
      ],
    );
  }
}
