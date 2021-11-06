import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class DrawerSideBar extends StatelessWidget {
  final UserState userState;
  DrawerSideBar({Key? key, required this.userState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String firstName = userState.userInfoGlobal.firstName;
    final String lastName = userState.userInfoGlobal.lastName;
    final String email = userState.userInfoGlobal.email;
    String initials = userState.userInfoGlobal.firstName[0] + " " + userState.userInfoGlobal.lastName[0];
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("$firstName $lastName",
                style: TextStyle(
                  color: Colors.blue,
                )),
            accountEmail: new Text("$email",
                style: TextStyle(
                  color: Colors.blue,
                )),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/lake.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: CircleAvatar(
               
                    child: Text('$initials'),
                ),
          ),
          new ListTile(
              leading: Icon(Icons.play_circle_filled_sharp),
              title: new Text("New Game"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.graphic_eq),
              title: new Text("Statistics"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.history_sharp),
              title: new Text("History"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.group),
              title: new Text("Leagues"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.price_change),
              title: new Text("Pricing"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.settings),
              title: new Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              }),
          new Divider(),
          new ListTile(
              leading: Icon(Icons.info),
              title: new Text("About"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.power_settings_new),
              title: new Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
