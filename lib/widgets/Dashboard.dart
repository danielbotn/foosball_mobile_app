import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foosball_mobile_app/api/User.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';
import 'package:foosball_mobile_app/widgets/dashboard_goals_chart.dart';
import 'package:foosball_mobile_app/widgets/dashboard_matches_chart.dart';
import 'drawer_sidebar.dart';
import 'package:flutter/foundation.dart';

class Dashboard extends StatefulWidget {
  final DashboardParam param;
  final String danni;
  Dashboard({Key? key, required this.param, required this.danni}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // State
  String firstName = "";
  String lastName = "";
  String email = "";
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
        email = value.email;
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
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.grey[700]),
            backgroundColor: Colors.white,
          ),
          drawer: DrawerSideBar(userState: widget.param.userState),
          body: FutureBuilder(
            future: user.getUserStats(),
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
                        trailing: Icon(Icons.food_bank),
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
