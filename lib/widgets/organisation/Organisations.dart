import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/widgets/emptyData/emptyData.dart';
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
  final String randomString;
  const Organisations(
      {Key? key, required this.userState, required this.randomString})
      : super(key: key);

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

  @override
  void didUpdateWidget(Organisations old) {
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(
              userState: widget.userState,
            );
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return EmptyData(
                userState: widget.userState,
                message: widget.userState.hardcodedStrings.noData,
                iconData: Icons.error);
          } else {
            return SafeArea(
              child: ListView.builder(
                itemCount: orgData!.length,
                itemBuilder: (context, index) {
                  String headline = getHeadline(orgData![index]);

                  return Card(
                    elevation: 0,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith((states) {
                          if (widget.userState.darkmode) {
                            return const BorderSide(
                                width: 1.0, color: AppColors.white);
                          }
                          return const BorderSide(
                              width: 1.0, color: AppColors.textGrey);
                        }),
                        checkColor: Colors.white,
                        activeColor: helpers
                            .getCheckMarkColor(widget.userState.darkmode),
                        value: checkIfCurrentOrganisation(orgData![index]),
                        onChanged: (bool? value) {
                          // to do
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
