import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Dato_CMS.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Settings extends StatefulWidget {
  final UserState userState;
  Settings({Key? key, required this.userState}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var selectedLanguage = "";
  bool isSwitched = false;

  late ThemeNotifier themeNotifier;
  var isDarkTheme;

  late Future<HardcodedStrings?> hardcodedStringsFuture;

  @override
  void initState() {
    super.initState();

    setSelectedLanguage(this.widget.userState.language);
    hardcodedStringsFuture =
        getHardcodedStrings(this.widget.userState.language);
  }

  // Get hardcoded strings from datoCMS
  Future<HardcodedStrings?> getHardcodedStrings(String language) async {
    DatoCMS datoCMS = new DatoCMS(token: this.widget.userState.token);
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
    final storage = new FlutterSecureStorage();
    String? darkTheme = await storage.read(key: 'dark_theme');
    setState(() {
      if (darkTheme == 'true') {
        this.widget.userState.setDarkmode(true);
      } else {
        this.widget.userState.setDarkmode(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    themeNotifier = Provider.of<ThemeNotifier>(context);

    changeTheme(bool value) async {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "dark_theme", value: value.toString());
      setState(() {
        isSwitched = value;
      });
      if (value == true) {
        this.widget.userState.setDarkmode(true);
        themeNotifier.setThemeMode(ThemeMode.light);
      } else {
        this.widget.userState.setDarkmode(false);
        themeNotifier.setThemeMode(ThemeMode.dark);
      }
    }

    // changes the language to the user's language
    // I think we need to use futurebuilder here
    changeHardcodedStrings(String language) {
      hardcodedStringsFuture = getHardcodedStrings(language);

      hardcodedStringsFuture.then((value) {
        if (value != null) {
          this.widget.userState.setHardcodedStrings(value);
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
      final storage = new FlutterSecureStorage();
      await storage.write(key: "language", value: value);
      setSelectedLanguage(value);
      this.widget.userState.setLanguage(value);
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

    // To do, use futurebuilder for language change as done in dashboard.dart file
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context, this.widget.userState);
            },
          ),
          iconTheme: userState.darkmode
              ? IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white),
      body: FutureBuilder(
          future: hardcodedStringsFuture,
          builder: (context, AsyncSnapshot<HardcodedStrings?> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Theme(
                      data: userState.darkmode
                          ? ThemeData.dark()
                          : ThemeData.light(),
                      child: SettingsList(
                        sections: [
                          SettingsSection(
                            titlePadding: EdgeInsets.all(20),
                            title: userState.hardcodedStrings.common,
                            tiles: [
                              SettingsTile(
                                title: userState.hardcodedStrings.language,
                                subtitle: selectedLanguage,
                                leading: Icon(Icons.language),
                                onPressed: (BuildContext context) {
                                  selectLanguagePopup(context);
                                },
                              ),
                              SettingsTile(
                                title: userState.hardcodedStrings.pricing,
                                subtitle: 'Premium',
                                leading: Icon(Icons.money),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile.switchTile(
                                title: userState.darkmode
                                    ? userState.hardcodedStrings.darkTheme
                                    : userState.hardcodedStrings.lightTheme,
                                leading: Icon(Icons.phone_android),
                                switchValue: userState.darkmode,
                                onToggle: (value) {
                                  changeTheme(value);
                                },
                              ),
                            ],
                          ),
                          // person section
                          SettingsSection(
                            titlePadding: EdgeInsets.all(20),
                            title: userState.hardcodedStrings.personalInformation,
                            tiles: [
                              SettingsTile(
                                title: userState.hardcodedStrings.username,
                                subtitle: userState.userInfoGlobal.email,
                                leading: Icon(Icons.email),
                                onPressed: (BuildContext context) {
                                  selectLanguagePopup(context);
                                },
                              ),
                              SettingsTile(
                                title: userState.hardcodedStrings.user,
                                subtitle: userState.userInfoGlobal.firstName + " " + userState.userInfoGlobal.lastName,
                                leading: Icon(Icons.person),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: userState.hardcodedStrings.organisation,
                                subtitle: userState.userInfoGlobal.currentOrganisationName,
                                leading: Icon(Icons.business),
                                onPressed: (BuildContext context) {},
                              ),
                            ],
                          ),
                          SettingsSection(
                            titlePadding: EdgeInsets.all(20),
                            title: userState.hardcodedStrings.security,
                            tiles: [
                              SettingsTile.switchTile(
                                title:
                                    userState.hardcodedStrings.changePassword,
                                leading: Icon(Icons.lock),
                                switchValue: true,
                                onToggle: (bool value) {},
                              ),
                              SettingsTile.switchTile(
                                title: userState
                                    .hardcodedStrings.enableNotifications,
                                enabled: false,
                                leading: Icon(Icons.notifications_active),
                                switchValue: true,
                                onToggle: (value) {},
                              ),
                            ],
                          ),
                        ],
                      )));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
