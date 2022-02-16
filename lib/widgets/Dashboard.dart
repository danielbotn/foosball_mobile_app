import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foosball_mobile_app/api/Dato_CMS.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/api/User.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/dashboard_goals_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard_last_five.dart';
import 'package:foosball_mobile_app/widgets/dashboard_matches_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard_quick_actions.dart';
import 'package:foosball_mobile_app/widgets/headline.dart';
import 'drawer_sidebar.dart';
import 'package:flutter/foundation.dart';

import 'loading.dart';

class Dashboard extends StatefulWidget {
  final UserState param;
  Dashboard({Key? key, required this.param}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // State
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
  late Future<UserStatsResponse>userStatsFuture = Future.value(UserStatsResponse(
      userId: 0,
      totalMatches: 0,
      totalMatchesWon: 0,
      totalMatchesLost: 0,
      totalGoalsScored: 0,
      totalGoalsReceived: 0));

  late UserState userStateState;

  @override
  void initState() {
    super.initState();
    String token = this.widget.param.token;
    String userId = this.widget.param.userId.toString();
    User user = new User(token: token);
    DatoCMS datoCMS = new DatoCMS(token: token);

    datoCMS.getHardcodedStrings(this.widget.param.language).then((value) {
      if (value != null) {
        // hardcoded strings put into global state
        this.widget.param.setHardcodedStrings(value);
      }
    });

    user.getUser(userId).then((value) {
      setState(() {
        firstName = value.firstName;
        lastName = value.lastName;
        email = value.email;
      });
      userStatsFuture = getUserStatsData(int.parse(userId), value.currentOrganisationId);
      
      // Set user information to global state??
      this.widget.param.setUserInfoGlobalObject(
          int.parse(userId),
          value.firstName,
          value.lastName,
          value.email,
          value.currentOrganisationId,
          organisationName);
    });

    getTheme();

    setState(() {
      userStateState = this.widget.param;
    });
  }

  Future<void> getTheme() async {
    final storage = new FlutterSecureStorage();
    String? darkTheme = await storage.read(key: 'dark_theme');
    setState(() {
      if (darkTheme == 'true') {
        this.widget.param.setDarkmode(true);
      } else {
        this.widget.param.setDarkmode(false);
      }
    });
  }

  // To do put functions here
  Future<UserStatsResponse> getUserStatsData(int userId, int currrentOrganisationId) async {
    String token = this.widget.param.token;
    User user = new User(token: token);
    Organisation organisation = new Organisation(token: token);
    var userStatsData = await user.getUserStats();
    userStatsResponse = userStatsData;
    int organisationId = this.widget.param.currentOrganisationId;
    organisation.getOrganisationById(organisationId).then((value) {
      if (value.statusCode == 200) {
        var organisationResponse =
            OrganisationResponse.fromJson(jsonDecode(value.body));
        setState(() {
          organisationName = organisationResponse.name;
        });
        setGlobal(userId, currrentOrganisationId, organisationResponse.name);
      } else {
        // To do error handling
      }
    });

    return userStatsData;
  }

  setGlobal(int userId, int currrentOrganisationId, String currentOrganisationName) {
    this.widget.param.setUserInfoGlobalObject(userId, firstName, lastName, email, currrentOrganisationId, currentOrganisationName);
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.param.darkmode;

    return MaterialApp(
        title: 'Dashboard',
        home: Scaffold(
          appBar: AppBar(
              iconTheme: darkMode
                  ? IconThemeData(color: AppColors.white)
                  : IconThemeData(color: Colors.grey[700]),
              backgroundColor:
                  darkMode ? AppColors.darkModeBackground : AppColors.white),
          drawer: DrawerSideBar(userState: widget.param),
          onDrawerChanged: (isOpen) {
            setState(() {
              userStateState = widget.param;
            });
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
                                leading: Icon(Icons.email, color: Colors.grey),
                                title: Text('$firstName' + ' $lastName'),
                                subtitle: Text('$email'),
                                trailing: Text('$organisationName'),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 200,
                                      child: DashboardMatchesChart(
                                        userState: userStateState,
                                        userStatsResponse: snapshot.data ?? null,
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 200,
                                      child: DashboardGoalsChart(
                                          userState: userStateState,
                                          userStatsResponse: snapshot.data ?? null),
                                    )),
                              ],
                            ),
                            Headline(
                                headline: userStateState
                                    .hardcodedStrings.quickActions,
                                userState: userState),
                            QuicActions(userState: userState),
                            Headline(
                                headline: userStateState
                                    .hardcodedStrings.lastTenMatches,
                                userState: userState),
                            Expanded(
                                flex: 1,
                                child: DashBoardLastFive(
                                  userState: this.widget.param,
                                ))
                          ],
                        )));
              } else {
                return Loading();
              }
            },
          ),
        ));
  }
}
