import 'dart:convert';

import 'package:flutter/material.dart';

import '../../api/Organisation.dart';
import '../../api/UserApi.dart';
import '../../models/organisation/organisation_response.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/preferences_service.dart';
import '../Login.dart';
import '../extended_Text.dart';
import '../../utils/helpers.dart';
import '../loading.dart';

class ChangeOrganisation extends StatefulWidget {
  final UserState userState;
  const ChangeOrganisation({Key? key, required this.userState})
      : super(key: key);

  @override
  State<ChangeOrganisation> createState() => _ChangeOrganisationState();
}

class _ChangeOrganisationState extends State<ChangeOrganisation> {
  // state
  late Future<List<UserResponse>?> playersFuture;
  late List<UserResponse>? playersData;

  late Future<List<OrganisationResponse>?> orgFuture;
  late List<OrganisationResponse>? orgData;

  @override
  void initState() {
    super.initState();
    playersFuture = getPlayersData();
    orgFuture = getOrganisationsByUser();
  }

  @override
  void didUpdateWidget(ChangeOrganisation old) {
    playersFuture = getPlayersData();
    orgFuture = getOrganisationsByUser();
    super.didUpdateWidget(old);
  }

  Future<List<UserResponse>?> getPlayersData() async {
    UserApi user = UserApi();
    var data = await user.getUsers();
    playersData = data;
    return data;
  }

  Future<List<OrganisationResponse>?> getOrganisationsByUser() async {
    Organisation api = Organisation();

    var data = await api.getOrganisationsByUser();

    orgData = data;
    return data;
  }

  String getHeadline(OrganisationResponse org) {
    return org.name;
  }

  bool checkIfCurrentOrganisation(OrganisationResponse org) {
    bool result = false;

    if (org.id == widget.userState.userInfoGlobal.currentOrganisationId) {
      result = true;
    }

    return result;
  }

  Future<bool> changeOrg(OrganisationResponse orgData) async {
    bool changedOrg = false;

    if (orgData.id != widget.userState.userInfoGlobal.currentOrganisationId) {
      // call api and change current organisation
      changedOrg = true;
      await showMyDialog(
          widget.userState.hardcodedStrings.changeOrganisationAlertText,
          widget.userState.hardcodedStrings.changeOrganisation,
          widget.userState.userInfoGlobal.currentOrganisationId,
          orgData.id);
    }

    return changedOrg;
  }

  void logoutUser() {
    PreferencesService preferencesService = PreferencesService();
    preferencesService.deleteDarkTheme();
    preferencesService.deleteLanguage();
    preferencesService.deleteJwtToken();
    preferencesService.deleteRefreshToken();

    widget.userState.setToken('');
    widget.userState.setCurrentOrganisationId(0);
    widget.userState.setUserId(0);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login(
                  userState: widget.userState,
                )));
  }

  // Dialog to show when user changes organisation
  Future<void> showMyDialog(String message, String headline, int organisationId,
      int newOrganisationId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(headline),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(widget.userState.hardcodedStrings.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(widget.userState.hardcodedStrings.yes),
              onPressed: () async {
                Organisation api = Organisation();
                var changeStatement = await api.changeOrganisation(
                    organisationId, newOrganisationId, widget.userState.userId);

                if (changeStatement.statusCode == 200) {
                  // log user out of system
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                  logoutUser();
                } else {
                  if (mounted) {
                    // show error message
                    Navigator.of(context);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.changeOrganisation,
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
            child: FutureBuilder(
              future: orgFuture,
              builder: (context,
                  AsyncSnapshot<List<OrganisationResponse>?> snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                      child: ListView.builder(
                    itemCount: orgData!.length,
                    itemBuilder: (context, index) {
                      String headline = getHeadline(orgData![index]);

                      return Card(
                        margin: EdgeInsets.zero,
                        color: widget.userState.darkmode
                            ? AppColors.darkModeBackground
                            : AppColors.white,
                        child: ListTile(
                          leading: Icon(
                            Icons.account_balance_rounded,
                            color: widget.userState.darkmode
                                ? AppColors.white
                                : AppColors.textGrey,
                          ),
                          title: ExtendedText(
                            text: headline,
                            userState: widget.userState,
                          ),
                          trailing: Checkbox(
                            checkColor: Colors.white,
                            activeColor: helpers
                                .getCheckMarkColor(widget.userState.darkmode),
                            value: checkIfCurrentOrganisation(orgData![index]),
                            onChanged: (bool? value) async {
                              // to do
                              await changeOrg(orgData![index]);
                            },
                          ),
                        ),
                      );
                    },
                  ));
                } else {
                  return const Loading();
                }
              },
            )));
  }
}
