import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[700]),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SettingsList(
          backgroundColor: Colors.white,
          sections: [
            SettingsSection(
              titlePadding: EdgeInsets.all(20),
              title: 'Common',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                 SettingsTile(
                  title: 'Pricing',
                  subtitle: 'Premium',
                  leading: Icon(Icons.money),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Light Theme',
                  leading: Icon(Icons.phone_android),
                  switchValue: isSwitched,
                  onToggle: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            SettingsSection(
              titlePadding: EdgeInsets.all(20),
              title: 'Security',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Change password',
                  leading: Icon(Icons.lock),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
                SettingsTile.switchTile(
                  title: 'Enable Notifications',
                  enabled: false,
                  leading: Icon(Icons.notifications_active),
                  switchValue: true,
                  onToggle: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
