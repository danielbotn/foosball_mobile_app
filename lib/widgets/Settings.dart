import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Dato_CMS.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/icons/custom_icons.dart';
import 'package:dano_foosball/models/cms/hardcoded_strings.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/Settings/DiscordSettings.dart';
import 'package:dano_foosball/widgets/Settings/MicrosoftTeamsSettings.dart';
import 'package:dano_foosball/widgets/Settings/SlackSettings.dart';
import 'package:dano_foosball/widgets/change_password/ChangePassword.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:settings_ui/settings_ui.dart';
import '../utils/preferences_service.dart';

class Settings extends StatefulWidget {
  final UserState userState;
  const Settings({Key? key, required this.userState}) : super(key: key);

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

  setSelectedLanguage(String language) {
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

  Future<void> getTheme() async {
    PreferencesService preferencesService = PreferencesService();
    bool? darkTheme = await preferencesService.getDarkTheme();
    setState(() {
      if (darkTheme == true) {
        widget.userState.setDarkmode(true);
      } else {
        widget.userState.setDarkmode(false);
      }
    });
  }

  @override
  void didPopNext() {
    // Called when this widget is navigated to again (comes back to the top of the stack).
    setState(() {
      organisationFuture = getOrganisation();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    changeTheme(bool value) async {
      PreferencesService preferencesService = PreferencesService();
      await preferencesService.setDarkTheme(value);
      setState(() {
        isSwitched = value;
      });
      if (value == true) {
        widget.userState.setDarkmode(true);
      } else {
        widget.userState.setDarkmode(false);
      }
    }

    changeHardcodedStrings(String language) {
      hardcodedStringsFuture = getHardcodedStrings(language);

      hardcodedStringsFuture.then((value) {
        if (value != null) {
          widget.userState.setHardcodedStrings(value);
        }
      });
    }

    setSelectedLanguage(String language) {
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

    setLanguage(String value) async {
      PreferencesService preferencesService = PreferencesService();
      await preferencesService.setLanguage(value);
      setSelectedLanguage(value);
      widget.userState.setLanguage(value);
      changeHardcodedStrings(value);
    }

    Future<void> selectLanguagePopup(BuildContext context) async {
      switch (await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Select language'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 'English');
                  },
                  child: const Text('English'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 'Icelandic');
                  },
                  child: const Text('Íslenska'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 'Swedish');
                  },
                  child: const Text('Svenska'),
                ),
              ],
            );
          })) {
        case 'English':
          setLanguage('en');
          break;
        case 'Icelandic':
          setLanguage('is');
          break;
        case 'Swedish':
          setLanguage('sv');
          break;
      }
    }

    goToChangePassword(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePassword(
            userState: widget.userState,
          ),
        ),
      );
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

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context, widget.userState);
            },
          ),
          iconTheme: widget.userState.darkmode
              ? const IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: widget.userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white),
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
                    SettingsSection(
                      title: Text(
                        hardcodedStrings?.common ?? "Common",
                      ),
                      tiles: [
                        SettingsTile(
                          title: Text(hardcodedStrings?.language ?? "Language"),
                          trailing: Text(selectedLanguage),
                          leading: const Icon(Icons.language),
                          onPressed: (BuildContext context) {
                            selectLanguagePopup(context);
                          },
                        ),
                        SettingsTile(
                          title: Text(hardcodedStrings?.pricing ?? "Pricing"),
                          trailing: const Text('Premium'),
                          leading: const Icon(Icons.money),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile.switchTile(
                          title: Text(
                            widget.userState.darkmode
                                ? hardcodedStrings?.darkTheme ?? "Dark Theme"
                                : hardcodedStrings?.lightTheme ?? "Light Theme",
                          ),
                          leading: const Icon(Icons.phone_android),
                          initialValue: widget.userState.darkmode,
                          onToggle: (value) {
                            changeTheme(value);
                          },
                        ),
                      ],
                    ),
                    // person section
                    SettingsSection(
                      title: Text(hardcodedStrings?.personalInformation ??
                          "Personal Information"),
                      tiles: [
                        SettingsTile(
                          title: Text(hardcodedStrings?.username ?? "Username"),
                          description:
                              Text(widget.userState.userInfoGlobal.email),
                          leading: const Icon(Icons.email),
                          onPressed: (BuildContext context) {
                            selectLanguagePopup(context);
                          },
                        ),
                        SettingsTile(
                          title: Text(hardcodedStrings?.user ?? "User"),
                          description: Text(
                              "${widget.userState.userInfoGlobal.firstName} ${widget.userState.userInfoGlobal.lastName}"),
                          leading: const Icon(Icons.person),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text(
                              hardcodedStrings?.organisation ?? "Organisation"),
                          description: Text(widget.userState.userInfoGlobal
                              .currentOrganisationName),
                          leading: const Icon(Icons.business),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                    // integrations
                    SettingsSection(
                      title:
                          Text(hardcodedStrings?.integration ?? "Integration"),
                      tiles: [
                        SettingsTile(
                          title: Text(hardcodedStrings?.slack ?? "Slack"),
                          description:
                              Text(organisation?.slackWebhookUrl ?? ""),
                          leading: const Icon(CustomIcons.slack),
                          onPressed: (BuildContext context) {
                            goToChangeSlackWebHook(context);
                          },
                        ),
                        SettingsTile(
                          title: Text(hardcodedStrings?.discord ?? "Discord"),
                          description:
                              Text(organisation?.discordWebhookUrl ?? ""),
                          leading: const Icon(CustomIcons.discord),
                          onPressed: (BuildContext context) {
                            goToChangeDiscordWebHook(context);
                          },
                        ),
                        SettingsTile(
                          title: const Text("Microsoft Teams"),
                          description: Text(
                              organisation?.microsoftTeamsWebhookUrl ?? ""),
                          leading: const Icon(Icons.window),
                          onPressed: (BuildContext context) {
                            goToChangeTeamsWebHook(context);
                          },
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: Text(hardcodedStrings?.security ?? "Security"),
                      tiles: [
                        SettingsTile(
                          title: Text(hardcodedStrings?.changePassword ??
                              "Change Password"),
                          leading: const Icon(Icons.lock),
                          onPressed: (BuildContext context) {
                            goToChangePassword(context);
                          },
                        ),
                        SettingsTile.switchTile(
                          title: Text(hardcodedStrings?.enableNotifications ??
                              "Enable Notifications"),
                          enabled: false,
                          leading: const Icon(Icons.notifications_active),
                          initialValue: true,
                          onToggle: (value) {},
                        ),
                      ],
                    ),
                  ],
                ));
          } else {
            return Center(
              child: Loading(
                userState: widget.userState,
              ),
            );
          }
        },
      ),
    );
  }
}
