import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Dato_CMS.dart';
import 'package:foosball_mobile_app/icons/custom_icons.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:settings_ui/settings_ui.dart';

import '../utils/preferences_service.dart';

class Settings extends StatefulWidget {
  final UserState userState;
  const Settings({Key? key, required this.userState}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var selectedLanguage = "";
  bool isSwitched = false;

  var isDarkTheme;

  late Future<HardcodedStrings?> hardcodedStringsFuture;

  @override
  void initState() {
    super.initState();

    setSelectedLanguage(widget.userState.language);
    hardcodedStringsFuture = getHardcodedStrings(widget.userState.language);
  }

  // Get hardcoded strings from datoCMS
  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    DatoCMS datoCMS = DatoCMS();
    var hardcodedStrings = await datoCMS.getHardcodedStrings(language);

    return hardcodedStrings;
  }

  // Sets the subtitle of the language selection
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

    // changes the language to the user's language
    // I think we need to use futurebuilder here
    changeHardcodedStrings(String language) {
      hardcodedStringsFuture = getHardcodedStrings(language);

      hardcodedStringsFuture.then((value) {
        if (value != null) {
          widget.userState.setHardcodedStrings(value);
        }
      });
    }

    // Sets the subtitle of the language selection
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

    // sets the language that the user chooses
    setLanguage(String value) async {
      PreferencesService preferencesService = PreferencesService();
      await preferencesService.setLanguage(value);
      setSelectedLanguage(value);
      widget.userState.setLanguage(value);
      changeHardcodedStrings(value);
    }

    // Popup menu for language selection
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

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context, widget.userState);
            },
          ),
          iconTheme: userState.darkmode
              ? const IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white),
      body: FutureBuilder(
          future: hardcodedStringsFuture,
          builder: (context, AsyncSnapshot<HardcodedStrings?> snapshot) {
            if (snapshot.hasData) {
              return Theme(
                  data:
                      userState.darkmode ? ThemeData.dark() : ThemeData.light(),
                  child: SettingsList(
                    sections: [
                      SettingsSection(
                        title: Text(
                          userState.hardcodedStrings.common,
                        ),
                        tiles: [
                          SettingsTile(
                            title: Text(userState.hardcodedStrings.language),
                            trailing: Text(selectedLanguage),
                            leading: const Icon(Icons.language),
                            onPressed: (BuildContext context) {
                              selectLanguagePopup(context);
                            },
                          ),
                          SettingsTile(
                            title: Text(userState.hardcodedStrings.pricing),
                            trailing: const Text('Premium'),
                            leading: const Icon(Icons.money),
                            onPressed: (BuildContext context) {},
                          ),
                          SettingsTile.switchTile(
                            title: Text(
                              userState.darkmode
                                  ? userState.hardcodedStrings.darkTheme
                                  : userState.hardcodedStrings.lightTheme,
                            ),
                            leading: const Icon(Icons.phone_android),
                            initialValue: userState.darkmode,
                            onToggle: (value) {
                              changeTheme(value);
                            },
                          ),
                        ],
                      ),
                      // person section
                      SettingsSection(
                        title: Text(
                            userState.hardcodedStrings.personalInformation),
                        tiles: [
                          SettingsTile(
                            title: Text(userState.hardcodedStrings.username),
                            description: Text(userState.userInfoGlobal.email),
                            leading: const Icon(Icons.email),
                            onPressed: (BuildContext context) {
                              selectLanguagePopup(context);
                            },
                          ),
                          SettingsTile(
                            title: Text(userState.hardcodedStrings.user),
                            description: Text(
                                "${userState.userInfoGlobal.firstName} ${userState.userInfoGlobal.lastName}"),
                            leading: const Icon(Icons.person),
                            onPressed: (BuildContext context) {},
                          ),
                          SettingsTile(
                            title:
                                Text(userState.hardcodedStrings.organisation),
                            description: Text(userState
                                .userInfoGlobal.currentOrganisationName),
                            leading: const Icon(Icons.business),
                            onPressed: (BuildContext context) {},
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
                            leading: const Icon(CustomIcons.slack),
                            onPressed: (BuildContext context) {
                              selectLanguagePopup(context);
                            },
                          ),
                          SettingsTile(
                            title: Text(userState.hardcodedStrings.discord),
                            description: const Text(
                                "https://hooks.discord.com/services/T0J5QJQQP/B0J5QJQQQ/0J5QJQQQQ"),
                            leading: const Icon(CustomIcons.discord),
                            onPressed: (BuildContext context) {
                              selectLanguagePopup(context);
                            },
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: Text(userState.hardcodedStrings.security),
                        tiles: [
                          SettingsTile.switchTile(
                            title:
                                Text(userState.hardcodedStrings.changePassword),
                            leading: const Icon(Icons.lock),
                            initialValue: true,
                            onToggle: (bool value) {},
                          ),
                          SettingsTile.switchTile(
                            title: Text(
                                userState.hardcodedStrings.enableNotifications),
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
