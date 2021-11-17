import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foosball_mobile_app/api/Dato_CMS.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/api/User.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';
import 'package:foosball_mobile_app/widgets/dashboard_goals_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard_last_five.dart';
import 'package:foosball_mobile_app/widgets/dashboard_matches_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard_quick_actions.dart';
import 'package:foosball_mobile_app/widgets/headline.dart';
import 'drawer_sidebar.dart';
import 'package:flutter/foundation.dart';

import 'loading.dart';

class Dashboard extends StatefulWidget {
  final DashboardParam param;
  final String danni;
  Dashboard({Key? key, required this.param, required this.danni})
      : super(key: key);

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
  late Future<UserStatsResponse> userStatsFuture;

  @override
  void initState() {
    super.initState();
    String token = this.widget.param.userState.token;
    String userId = this.widget.param.userState.userId.toString();
    User user = new User(token: token);
    DatoCMS datoCMS = new DatoCMS(token: token);

    datoCMS.getHardcodedStrings("is").then((value) {
     if (value != null) {
       // hardcoded strings put into global state
       this.widget.param.userState.setHardcodedStrings(value);
     }
    });

    user.getUser(userId).then((value) {
      setState(() {
        firstName = value.firstName;
        lastName = value.lastName;
        email = value.email;
      });
      // Set user information to global state??
      this.widget.param.userState.setUserInfoGlobalObject(
          int.parse(userId),
          value.firstName,
          value.lastName,
          value.email,
          value.currentOrganisationId);
    });

    userStatsFuture = getUserStatsData();
  }

  // To do put functions here
  Future<UserStatsResponse> getUserStatsData() async {
    String token = this.widget.param.userState.token;
    User user = new User(token: token);
    Organisation organisation = new Organisation(token: token);
    var userStatsData = await user.getUserStats();
    userStatsResponse = userStatsData;
    int organisationId = this.widget.param.userState.currentOrganisationId;
    organisation.getOrganisationById(organisationId).then((value) {
      if (value.statusCode == 200) {
        var organisationResponse =
            OrganisationResponse.fromJson(jsonDecode(value.body));
        setState(() {
          organisationName = organisationResponse.name;
        });
      } else {
        print('some error has accoured');
      }
    });

    return userStatsData;
  }

  @override
  Widget build(BuildContext context) {
    User user = new User(token: this.widget.param.userState.token);
    return MaterialApp(
        title: 'Dashboard',
        home: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.grey[700]),
            backgroundColor: Colors.white,
          ),
          drawer: DrawerSideBar(userState: widget.param.userState),
          body: FutureBuilder(
            future: userStatsFuture,
            builder: (context, AsyncSnapshot<UserStatsResponse> snapshot) {
              if (snapshot.hasData) {
                return Column(
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
                                  userState: widget.param.userState,
                                  userStatsResponse: snapshot.data),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: 200,
                              child: DashboardGoalsChart(
                                  userState: widget.param.userState,
                                  userStatsResponse: snapshot.data),
                            )),
                      ],
                    ),
                    Headline(headline: "Quick Actions"),
                    QuicActions(),
                    Headline(headline: "Last Ten matches"),
                    Expanded(
                        flex: 1,
                        child: DashBoardLastFive(
                          userState: this.widget.param.userState,
                        ))
                  ],
                );
              } else {
                return Loading();
              }
            },
          ),
        ));
  }
}
