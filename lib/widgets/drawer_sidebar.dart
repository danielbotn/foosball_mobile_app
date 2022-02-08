import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/Settings.dart';
import 'package:foosball_mobile_app/widgets/history.dart';

class DrawerSideBar extends StatefulWidget {
  // Props variables
  final UserState userState;
  DrawerSideBar({Key? key, required this.userState}) : super(key: key);

  @override
  _DrawerSideBarState createState() => _DrawerSideBarState();
}

class _DrawerSideBarState extends State<DrawerSideBar> {
  // State variables
  String firstName = userState.userInfoGlobal.firstName;
  String lastName = userState.userInfoGlobal.lastName;
  String email = userState.userInfoGlobal.email;
  String initials = userState.userInfoGlobal.firstName[0] +
      " " +
      userState.userInfoGlobal.lastName[0];
  String newGame = userState.hardcodedStrings.newGame;
  String statistics = userState.hardcodedStrings.statistics;
  String history = userState.hardcodedStrings.history;
  String leagues = userState.hardcodedStrings.leagues;
  String pricing = userState.hardcodedStrings.pricing;
  String settings = userState.hardcodedStrings.settings;
  String about = userState.hardcodedStrings.about;
  String logout = userState.hardcodedStrings.logout;
  String organisation = userState.hardcodedStrings.organisation;

  // Sets all the state variables on the sidebar
  setAllStates(UserState userStateParam) {
    setState(() {
      newGame = userStateParam.hardcodedStrings.newGame;
      statistics = userStateParam.hardcodedStrings.statistics;
      history = userStateParam.hardcodedStrings.history;
      leagues = userStateParam.hardcodedStrings.leagues;
      pricing = userStateParam.hardcodedStrings.pricing;
      settings = userStateParam.hardcodedStrings.settings;
      about = userStateParam.hardcodedStrings.about;
      logout = userStateParam.hardcodedStrings.logout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            margin: EdgeInsets.only(bottom: 0.0),
            accountName: new Text("$firstName $lastName",
                style: TextStyle(
                  color: userState.darkmode ? Colors.white : Colors.blue,
                )),
            accountEmail: new Text("$email",
                style: TextStyle(
                  color: userState.darkmode ? Colors.white : Colors.blue,
                )),
            decoration: BoxDecoration(
              color: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
            ),
            currentAccountPicture: CircleAvatar(
              child: Text('$initials'),
            ),
          ),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.play_circle_filled_sharp,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$newGame',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.houseboat,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$organisation',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.graphic_eq,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$statistics',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.history_sharp,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$history',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () async {
                final UserState userStateFromHistory = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History(
                            userState: userState,
                          )),
                );
                setAllStates(userStateFromHistory);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.group,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$leagues',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.price_change,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$pricing',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.settings,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$settings',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () async {
                final UserState userStateFromSettings = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Settings(
                            userState: userState,
                          )),
                );
                setAllStates(userStateFromSettings);
              }),
          new Container(
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
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.info,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$about',
                  style: TextStyle(
                      color: userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack)),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              tileColor: userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              leading: Icon(Icons.power_settings_new,
                  color: userState.darkmode ? AppColors.white : null),
              title: new Text('$logout',
                  style: TextStyle(
                      color: userState.darkmode ? AppColors.white : null)),
              onTap: () {
                Navigator.pop(context);
              }),
          new Container(
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
