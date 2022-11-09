import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../api/Organisation.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class OrganisationManagePlayer extends StatefulWidget {
  final UserState userState;
  final UserResponse userData;
  const OrganisationManagePlayer(
      {Key? key, required this.userState, required this.userData})
      : super(key: key);

  @override
  State<OrganisationManagePlayer> createState() =>
      _OrganisationManagePlayerState();
}

class _OrganisationManagePlayerState extends State<OrganisationManagePlayer> {
  // state
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isChecked = widget.userData.isAdmin!;
    });
  }

  List<AbstractSettingsTile> setTiles() {
    bool isAdmin = false;
    isAdmin = widget.userData.isAdmin!;

    List<AbstractSettingsTile> result = [
      SettingsTile(
        title: Text(widget.userData.firstName + widget.userData.lastName),
        leading: Image.network(widget.userData.photoUrl, width: 40, height: 40),
        trailing: GestureDetector(
          child: Text(widget.userState.hardcodedStrings.deleteUser),
          onTap: () {
            // Delete User
          },
        ),
      ),
      SettingsTile.switchTile(
        title: Text(widget.userState.hardcodedStrings.admin),
        leading: const Icon(Icons.phone_android),
        initialValue: isChecked,
        onToggle: (value) async {
          String token = widget.userState.token;
          Organisation organisation = Organisation(token: token);
          int oId = 0;
          if (widget.userData.currentOrganisationId != null) {
            oId = widget.userData.currentOrganisationId!;
          }
          var updateOperation = await organisation.updateUserIsAdmin(
              oId, widget.userData.id, value);

          isAdmin = !value;
          if (updateOperation.statusCode == 204) {
            setState(() {
              isChecked = !isChecked;
            });
          }
        },
      ),
    ];

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.managePlayer,
                userState: widget.userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(widget.userState.darkmode),
            backgroundColor:
                helpers.getBackgroundColor(widget.userState.darkmode)),
        body: Container(
            color: widget.userState.darkmode
                ? AppColors.darkModeBackground
                : AppColors.white,
            child: Theme(
                data: widget.userState.darkmode
                    ? ThemeData.dark()
                    : ThemeData.light(),
                child: SettingsList(
                  sections: [
                    SettingsSection(
                        title: Text(
                          widget.userState.hardcodedStrings.actions,
                        ),
                        tiles: setTiles()),
                  ],
                ))));
  }
}
