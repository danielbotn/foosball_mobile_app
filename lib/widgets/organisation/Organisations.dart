import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

import '../../api/UserApi.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../loading.dart';
import '../../api/Organisation.dart';

class Organisations extends StatefulWidget {
  final UserState userState;
  const Organisations({Key? key, required this.userState}) : super(key: key);

  @override
  State<Organisations> createState() => _OrganisationsState();
}

class _OrganisationsState extends State<Organisations> {
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

  Future<List<UserResponse>?> getPlayersData() async {
    String token = widget.userState.token;
    UserApi user = UserApi(token: token);
    var data = await user.getUsers();
    playersData = data;
    return data;
  }

  Future<List<OrganisationResponse>> getOrganisationsByUser() async {
    String token = widget.userState.token;
    Organisation api = Organisation(token: token);

    var data = await api.getOrganisationsByUser();

    List<OrganisationResponse> organisations;
    organisations = (json.decode(data.body) as List)
        .map((i) => OrganisationResponse.fromJson(i))
        .toList();

    orgData = organisations;
    return organisations;
  }

  String getHeadline(OrganisationResponse org) {
    return org.name;
  }

  bool checkIfCurrentOrganisation(OrganisationResponse org) {
    bool result = false;

    if (org.id == userState.userInfoGlobal.currentOrganisationId) {
      result = true;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Container(
        color:
            userState.darkmode ? AppColors.darkModeBackground : AppColors.white,
        child: FutureBuilder(
          future: orgFuture,
          builder:
              (context, AsyncSnapshot<List<OrganisationResponse>?> snapshot) {
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
                        color: userState.darkmode
                            ? AppColors.white
                            : AppColors.textGrey,
                      ),
                      title: ExtendedText(
                        text: headline,
                        userState: userState,
                      ),
                      trailing: Checkbox(
                        checkColor: Colors.white,
                        activeColor:
                            helpers.getCheckMarkColor(userState.darkmode),
                        value: checkIfCurrentOrganisation(orgData![index]),
                        onChanged: (bool? value) {
                          // to do
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
        ));
  }
}
