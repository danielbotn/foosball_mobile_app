import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Dato_CMS.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/api/TokenHelper.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_goals_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_last_five.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_matches_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_quick_actions.dart';
import 'package:foosball_mobile_app/widgets/drawer_sidebar.dart';
import 'package:foosball_mobile_app/widgets/headline.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class NewDashboard extends StatefulWidget {
  final UserState userState;
  const NewDashboard({Key? key, required this.userState}) : super(key: key);

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  // state
  String firstName = "";
  String lastName = "";
  String email = "";
  String organisationName = "";
  UserStatsResponse userStatsResponse = UserStatsResponse(
      userId: 0,
      totalMatches: 0,
      totalMatchesWon: 0,
      totalMatchesLost: 0,
      totalGoalsScored: 0,
      totalGoalsReceived: 0);
  late Future<UserStatsResponse> userStatsFuture = Future.value(
      UserStatsResponse(
          userId: 0,
          totalMatches: 0,
          totalMatchesWon: 0,
          totalMatchesLost: 0,
          totalGoalsScored: 0,
          totalGoalsReceived: 0));

  Future getHardcodedStrings() async {
    DatoCMS datoCMS = DatoCMS();
    var hardcodedStrings =
        await datoCMS.getHardcodedStrings(widget.userState.language);

    if (hardcodedStrings != null) {
      widget.userState.setHardcodedStrings(hardcodedStrings);
    }
    print("getHardcodedStrings() INSIDE finished");
  }

  Future<UserResponse> getUser() async {
    UserApi user = UserApi();
    String userId = widget.userState.userId.toString();
    var userData = await user.getUser(userId);

    setState(() {
      firstName = userData.firstName;
      lastName = userData.lastName;
      email = userData.email;
    });
    print("getUser() INSIDE FINISH");
    return userData;
  }

  Future<OrganisationResponse?> getOrganisationById(int userId) async {
    Organisation orgApi = Organisation();
    int organisationId = widget.userState.currentOrganisationId;
    var data = await orgApi.getOrganisationById(organisationId);
    if (data.statusCode == 200) {
      var organisationResponse =
          OrganisationResponse.fromJson(jsonDecode(data.body));
      setState(() {
        organisationName = organisationResponse.name;
      });
      setGlobal(userId, organisationResponse.id, organisationResponse.name);
      print("getOrganisationById() INSIDE FINISH");

      return organisationResponse;
    }
    return null;
  }

  Future<UserStatsResponse> getUserStatsData(
      int userId, int currrentOrganisationId) async {
    UserApi user = UserApi();
    var userStatsData = await user.getUserStats();
    userStatsResponse = userStatsData;
    print("getUserStatsData() INSIDE FINISH");
    return userStatsData;
  }

  setGlobal(
      int userId, int currrentOrganisationId, String currentOrganisationName) {
    widget.userState.setUserInfoGlobalObject(userId, firstName, lastName, email,
        currrentOrganisationId, currentOrganisationName);
  }

  Future<void> initialize() async {
    print("initialize function called");
    await getHardcodedStrings();
    print("getHardcodedStrings finished");
    var user = await getUser();
    print("getUser finished");
    var orgData = await getOrganisationById(user.id);
    print("getOrganisationById finisehed");
    if (orgData != null) {
      userStatsFuture = getUserStatsData(user.id, orgData.id);
      print("userStatsFuture finisehd");
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void updateAllState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    return MaterialApp(
        title: 'Dashboard',
        home: Scaffold(
          appBar: AppBar(
              iconTheme: darkMode
                  ? const IconThemeData(color: AppColors.white)
                  : IconThemeData(color: Colors.grey[700]),
              backgroundColor:
                  darkMode ? AppColors.darkModeBackground : AppColors.white),
          drawer: DrawerSideBar(
            userState: widget.userState,
            notifyParent: updateAllState,
          ),
          onDrawerChanged: (isOpen) {
            // setState(() {
            //   userStateState = widget.param;
            // });
          },
          body: FutureBuilder(
            future: userStatsFuture,
            builder: (context, AsyncSnapshot<UserStatsResponse> snapshot) {
              if (snapshot.hasData) {
                return Theme(
                    data: darkMode ? ThemeData.dark() : ThemeData.light(),
                    child: Container(
                        color: darkMode
                            ? AppColors.darkModeBackground
                            : AppColors.white,
                        child: Column(
                          children: <Widget>[
                            Card(
                              // elevation: 5,
                              child: ListTile(
                                leading:
                                    const Icon(Icons.email, color: Colors.grey),
                                title: Text('$firstName $lastName'),
                                subtitle: Text(email),
                                trailing: Text(organisationName),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 200,
                                      child: DashboardMatchesChart(
                                        userState: widget.userState,
                                        userStatsResponse: snapshot.data,
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 200,
                                      child: DashboardGoalsChart(
                                          userState: widget.userState,
                                          userStatsResponse: snapshot.data),
                                    )),
                              ],
                            ),
                            Headline(
                                headline: widget
                                    .userState.hardcodedStrings.quickActions,
                                userState: widget.userState),
                            QuicActions(
                              userState: widget.userState,
                              notifyParent: updateAllState,
                            ),
                            Headline(
                                headline: widget
                                    .userState.hardcodedStrings.lastTenMatches,
                                userState: widget.userState),
                            Expanded(
                                flex: 1,
                                child: DashBoardLastFive(
                                  userState: widget.userState,
                                ))
                          ],
                        )));
              } else {
                return const Loading();
              }
            },
          ),
        ));
  }
}
