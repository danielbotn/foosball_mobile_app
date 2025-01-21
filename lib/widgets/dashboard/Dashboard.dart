import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Dato_CMS.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/api/UserApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/charts/user_stats_response.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'dashboard_goals_chart.dart';
import 'dashboard_last_five.dart';
import 'dashboard_matches_chart.dart';
import 'dashboard_quick_actions.dart';
import 'package:dano_foosball/widgets/headline.dart';
import '../../utils/preferences_service.dart';
import '../drawer_sidebar.dart';
import '../loading.dart';

class Dashboard extends StatefulWidget {
  final UserState param;
  const Dashboard({Key? key, required this.param}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
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
  late Future<UserStatsResponse> userStatsFuture = Future.value(
      UserStatsResponse(
          userId: 0,
          totalMatches: 0,
          totalMatchesWon: 0,
          totalMatchesLost: 0,
          totalGoalsScored: 0,
          totalGoalsReceived: 0));

  // late UserState userStateState;

  @override
  void initState() {
    super.initState();
    String userId = widget.param.userId.toString();
    UserApi user = UserApi();
    DatoCMS datoCMS = DatoCMS();

    datoCMS.getHardcodedStrings(widget.param.language).then((value) {
      if (value != null) {
        // hardcoded strings put into global state
        widget.param.setHardcodedStrings(value);
      }
      user.getUser(userId).then((value) {
        setState(() {
          firstName = value.firstName;
          lastName = value.lastName;
          email = value.email;
        });
        int currentOID = 0;
        if (value.currentOrganisationId != null) {
          currentOID = value.currentOrganisationId!;
        }
        userStatsFuture = getUserStatsData(int.parse(userId), currentOID);

        // Set user information to global state??
        widget.param.setUserInfoGlobalObject(int.parse(userId), value.firstName,
            value.lastName, value.email, currentOID, organisationName, null);
      });

      getTheme();

      // setState(() {
      //   userStateState = widget.param;
      // });
    });
  }

  Future<void> getTheme() async {
    PreferencesService preferencesService = PreferencesService();
    bool? darkTheme = await preferencesService.getDarkTheme();
    setState(() {
      if (darkTheme == true) {
        widget.param.setDarkmode(true);
      } else {
        widget.param.setDarkmode(false);
      }
    });
  }

  // To do put functions here
  Future<UserStatsResponse> getUserStatsData(
      int userId, int currrentOrganisationId) async {
    UserApi user = UserApi();
    Organisation organisation = Organisation();
    var userStatsData = await user.getUserStats();
    userStatsResponse = userStatsData;
    int organisationId = widget.param.currentOrganisationId;
    organisation.getOrganisationById(organisationId).then((value) {
      if (value != null) {
        setState(() {
          organisationName = value.name;
        });
        setGlobal(userId, currrentOrganisationId, value.name);
      } else {
        // To do error handling
      }
    });

    return userStatsData;
  }

  setGlobal(
      int userId, int currrentOrganisationId, String currentOrganisationName) {
    widget.param.setUserInfoGlobalObject(userId, firstName, lastName, email,
        currrentOrganisationId, currentOrganisationName, null);
  }

  void updateAllState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.param.darkmode;

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
            userState: widget.param,
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
                                        userState: widget.param,
                                        userStatsResponse: snapshot.data,
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 200,
                                      child: DashboardGoalsChart(
                                          userState: widget.param,
                                          userStatsResponse: snapshot.data),
                                    )),
                              ],
                            ),
                            Headline(
                                headline:
                                    widget.param.hardcodedStrings.quickActions,
                                userState: userState),
                            QuicActions(
                              userState: userState,
                              notifyParent: updateAllState,
                            ),
                            Headline(
                                headline: widget
                                    .param.hardcodedStrings.lastTenMatches,
                                userState: userState),
                            Expanded(
                                flex: 1,
                                child: DashBoardLastFive(
                                  userState: widget.param,
                                ))
                          ],
                        )));
              } else {
                return Loading(
                  userState: widget.param,
                );
              }
            },
          ),
        ));
  }
}
