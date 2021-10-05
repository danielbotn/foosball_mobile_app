import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foosball_mobile_app/api/User.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';
import 'package:foosball_mobile_app/widgets/dashboard_matches_chart.dart';
import 'drawer_sidebar.dart';
import 'package:flutter/foundation.dart';

class Dashboard extends StatefulWidget {
  final DashboardParam param;
  Dashboard({Key? key, required this.param}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // State
  String firstName = "";
  String lastName = "";
  UserStatsResponse userStatsResponse = UserStatsResponse(
      userId: 0,
      totalMatches: 0,
      totalMatchesWon: 0,
      totalMatchesLost: 0,
      totalGoalsScored: 0,
      totalGoalsReceived: 0);

  @override
  void initState() {
    super.initState();
    String token = this.widget.param.userState.token;
    String userId = this.widget.param.userState.userId.toString();
    User user = new User(token: token);

    user.getUser(userId).then((value) {
      setState(() {
        firstName = value.firstName;
        lastName = value.lastName;
      });
    });

    user.getUserStats().then((value) {
      setState(() {
        userStatsResponse = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = new User(token: this.widget.param.userState.token);
    return MaterialApp(
        title: 'Dashboard',
        home: Scaffold(
          appBar: AppBar(title: Text('$firstName' + ' $lastName')),
          drawer: DrawerSideBar(userState: widget.param.userState),
          body: FutureBuilder(
            future: user.getUserStats(),
            builder: (context, AsyncSnapshot<UserStatsResponse> snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 1,
                  children: <Widget>[
                    Container(
                      child: DashboardMatchesChart(
                          userState: widget.param.userState,
                          userStatsResponse: snapshot.data),
                    ),
                  ],
                );
              } else {
                return Text('Loading...');
              }
            },
          ),
        ));
  }
}
