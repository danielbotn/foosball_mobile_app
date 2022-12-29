import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:foosball_mobile_app/widgets/Login.dart';
import 'package:foosball_mobile_app/widgets/Settings.dart';
import 'package:foosball_mobile_app/widgets/history.dart';

import 'new_game/new_game.dart';
import 'organisation/organisation.dart';

class DrawerSideBar extends StatefulWidget {
  // Props variables
  final UserState userState;
  final Function() notifyParent;
  const DrawerSideBar(
      {Key? key, required this.userState, required this.notifyParent})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
  String statistics = userState.hardcodedStrings.statistics;
  String history = userState.hardcodedStrings.history;
  String leagues = userState.hardcodedStrings.leagues;
  String pricing = userState.hardcodedStrings.pricing;
  String settings = userState.hardcodedStrings.settings;
  String about = userState.hardcodedStrings.about;
  String logout = userState.hardcodedStrings.logout;
  String organisation = userState.hardcodedStrings.organisation;

  void logoutUser() async {
    PreferencesService preferencesService = PreferencesService();
    preferencesService.deleteDarkTheme();
    preferencesService.deleteLanguage();
    preferencesService.deleteJwtToken();
    preferencesService.deleteRefreshToken();

    userState.setToken('');
    userState.setCurrentOrganisationId(0);
    userState.setUserId(0);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login(
                  userState: userState,
                )));
  }

  goToOrganisation(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrganisationScreen(
                  userState: userState,
                )));
  }

  goToNewGame(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewGame(
                  userState: userState,
                )));
  }

  goToHistory(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => History(
                  userState: userState,
                )));
  }

  goToSettings(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Settings(
                  userState: userState,
                ))).then(((value) {
      widget.notifyParent();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: const EdgeInsets.only(bottom: 0.0),
            accountName: Text("$firstName $lastName",
                style: TextStyle(
                  color: userState.darkmode ? Colors.white : Colors.blue,
                )),
            accountEmail: Text(email,
                style: TextStyle(
                  color: userState.darkmode ? Colors.white : Colors.blue,
                )),
            decoration: BoxDecoration(
              color: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(initials),
            ),
          ),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.play_circle_filled_sharp,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(newGame,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.of(context).pop();
                goToNewGame(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.houseboat,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(organisation,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
                goToOrganisation(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.graphic_eq,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(statistics,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.history_sharp,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(history,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.of(context).pop();
                goToHistory(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.group,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(leagues,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.price_change,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(pricing,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.settings,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(settings,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.of(context).pop();
                goToSettings(context);
              }),
          Container(
            height: 10.0,
            //this does the work for divider
            decoration: BoxDecoration(
                color: userState.darkmode
                    ? AppColors.darkModeBackground
                    : AppColors.white,
                border: Border(
                    bottom: BorderSide(
                        color: userState.darkmode
                            ? AppColors.darkModeBackground
                            : AppColors.white,
                        width: 7.0))),
          ),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.info,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(about,
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.power_settings_new,
                  color: userState.darkmode ? AppColors.white : null),
              title: Text(logout,
                  style: TextStyle(
                      color: userState.darkmode ? AppColors.white : null)),
              onTap: () {
                Navigator.pop(context);
                logoutUser();
              }),
          Container(
              height: 100,
              width: 100,
              color: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white),
        ],
      ),
    );
  }
}
