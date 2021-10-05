import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/widgets/dashboard_matches_chart.dart';
import 'drawer_sidebar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
  UserStatsResponse userStatsResponse = UserStatsResponse(userId: 0, totalMatches: 0, totalMatchesWon: 0, totalMatchesLost: 0, totalGoalsScored: 0, totalGoalsReceived: 0);

  Future<void> _getUser() async {
    String? baseUrl = kReleaseMode ? dotenv.env['REST_URL_PATH_PROD'] : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
       var url = Uri.parse(baseUrl + '/api/Users/' + this.widget.param.userState.userId.toString());
       String token = this.widget.param.userState.token;
       var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var userResponse = UserResponse.fromJson(jsonDecode(response.body));
        setState(() {
          firstName = userResponse.firstName;
          lastName = userResponse.lastName;
        });
      } else {
        // To do Error handling
      }
    }
  }

  Future<UserStatsResponse> _getUserStats() async {
    late UserStatsResponse result;
    String? baseUrl = kReleaseMode ? dotenv.env['REST_URL_PATH_PROD'] : dotenv.env['REST_URL_PATH_DEV'];
    if (baseUrl != null) {
       var url = Uri.parse(baseUrl + '/api/Users/stats');
       String token = this.widget.param.userState.token;
       var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var dta = UserStatsResponse.fromJson(jsonDecode(response.body));
        result = new UserStatsResponse(
          totalGoalsReceived: dta.totalGoalsReceived, 
          totalGoalsScored: dta.totalGoalsScored, 
          totalMatches: dta.totalMatches, 
          totalMatchesLost: dta.totalMatchesLost, 
          totalMatchesWon: dta.totalMatchesWon, 
          userId: dta.userId
        );
         
      } else {
        // To do Error handling
      }
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _getUserStats().then((value) {
      setState(() {
        userStatsResponse = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text('$firstName' + ' $lastName')
        ),
        drawer: DrawerSideBar(userState: widget.param.userState),
        body: FutureBuilder(
        future: _getUserStats(),
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
                  child: DashboardMatchesChart(userState: widget.param.userState, userStatsResponse: snapshot.data),
                ),
              
              ],
            );
          } else {
            return Text('Loading...');
          }
        },
      ),
      )
    );
  }
}
