import 'dart:io';

import 'package:dano_foosball/widgets/foosball_table/foosball_dashboard/foosball_dashboard.dart';
import 'package:dano_foosball/widgets/live_matches/live_matches.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/preferences_service.dart';
import 'package:dano_foosball/widgets/Login.dart';
import 'package:dano_foosball/widgets/Settings.dart';
import 'package:dano_foosball/widgets/history.dart';
import 'package:dano_foosball/widgets/league/League.dart';
// Import the LiveMatches screen

import 'new_game/new_game.dart';
import 'organisation/organisation.dart';

class DrawerSideBar extends StatefulWidget {
  // Props variables
  final UserState userState;
  final Function() notifyParent;
  const DrawerSideBar({
    Key? key,
    required this.userState,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _DrawerSideBarState createState() => _DrawerSideBarState();
}

class _DrawerSideBarState extends State<DrawerSideBar> {
  // State variables
  String firstName = userState.userInfoGlobal.firstName;
  String lastName = userState.userInfoGlobal.lastName;
  String email = userState.userInfoGlobal.email;
  String initials =
      "${userState.userInfoGlobal.firstName[0]} ${userState.userInfoGlobal.lastName[0]}";
  String newGame = userState.hardcodedStrings.newGame;
  String history = userState.hardcodedStrings.history;
  String leagues = userState.hardcodedStrings.leagues;
  String settings = userState.hardcodedStrings.settings;
  String logout = userState.hardcodedStrings.logout;
  String organisation = userState.hardcodedStrings.organisation;
  String liveMatches = "Live Matches"; // New string

  void logoutUser() async {
    PreferencesService preferencesService = PreferencesService();
    preferencesService.deleteDarkTheme();
    preferencesService.deleteLanguage();
    preferencesService.deleteJwtToken();
    preferencesService.deleteRefreshToken();

    userState.setToken('');
    userState.setCurrentOrganisationId(0);
    userState.setUserId(0);

    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FoosballDashboard(userState: userState),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login(userState: userState)),
      );
    }
  }

  goToOrganisation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrganisationScreen(userState: userState),
      ),
    );
  }

  goToNewGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewGame(userState: userState)),
    );
  }

  goToHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => History(userState: userState)),
    );
  }

  goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings(userState: userState)),
    ).then(((value) {
      widget.notifyParent();
    }));
  }

  goToLeague(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => League(userState: userState)),
    ).then(((value) {
      widget.notifyParent();
    }));
  }

  goToLiveMatches(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveMatches(userState: userState),
      ),
    ).then(((value) {
      widget.notifyParent();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: userState.darkmode
            ? AppColors.darkModeLighterBackground
            : AppColors.white,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
              color: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Image.network(
                      widget.userState.userInfoGlobal.photoUrl ?? "",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$firstName $lastName",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: userState.darkmode
                          ? Colors.white
                          : AppColors.surfaceDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: userState.darkmode
                          ? Colors.white
                          : AppColors.surfaceDark,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              dense: true,
              tileColor: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              leading: Icon(
                Icons.play_circle_filled_sharp,
                color: userState.darkmode ? AppColors.white : null,
                size: 22,
              ),
              title: Text(
                newGame,
                style: TextStyle(
                  fontSize: 14,
                  color: userState.darkmode
                      ? AppColors.white
                      : AppColors.surfaceDark,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                goToNewGame(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              dense: true,
              tileColor: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              leading: Icon(
                Icons.houseboat,
                color: userState.darkmode ? AppColors.white : null,
                size: 22,
              ),
              title: Text(
                organisation,
                style: TextStyle(
                  fontSize: 14,
                  color: userState.darkmode
                      ? AppColors.white
                      : AppColors.surfaceDark,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                goToOrganisation(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              dense: true,
              tileColor: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              leading: Icon(
                Icons.history_sharp,
                color: userState.darkmode ? AppColors.white : null,
                size: 22,
              ),
              title: Text(
                history,
                style: TextStyle(
                  fontSize: 14,
                  color: userState.darkmode
                      ? AppColors.white
                      : AppColors.surfaceDark,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                goToHistory(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              dense: true,
              tileColor: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              leading: Icon(
                Icons.group,
                color: userState.darkmode ? AppColors.white : null,
                size: 22,
              ),
              title: Text(
                leagues,
                style: TextStyle(
                  fontSize: 14,
                  color: userState.darkmode
                      ? AppColors.white
                      : AppColors.surfaceDark,
                ),
              ),
              onTap: () {
                goToLeague(context);
              },
            ),
            Visibility(
              visible: userState.currentOrganisationId != 0,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                dense: true,
                tileColor: userState.darkmode
                    ? AppColors.darkModeLighterBackground
                    : AppColors.white,
                leading: Icon(
                  Icons.live_tv,
                  color: userState.darkmode ? AppColors.white : null,
                  size: 22,
                ),
                title: Text(
                  liveMatches,
                  style: TextStyle(
                    fontSize: 14,
                    color: userState.darkmode
                        ? AppColors.white
                        : AppColors.surfaceDark,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  goToLiveMatches(context);
                },
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              dense: true,
              tileColor: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              leading: Icon(
                Icons.settings,
                color: userState.darkmode ? AppColors.white : null,
                size: 22,
              ),
              title: Text(
                settings,
                style: TextStyle(
                  fontSize: 14,
                  color: userState.darkmode
                      ? AppColors.white
                      : AppColors.surfaceDark,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                goToSettings(context);
              },
            ),
            ListTile(
              key: const Key("logout"),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              dense: true,
              tileColor: userState.darkmode
                  ? AppColors.darkModeLighterBackground
                  : AppColors.white,
              leading: Icon(
                Icons.power_settings_new,
                color: userState.darkmode ? AppColors.white : null,
                size: 22,
              ),
              title: Text(
                logout,
                style: TextStyle(
                  fontSize: 14,
                  color: userState.darkmode ? AppColors.white : null,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                logoutUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
