import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/User.dart';
import 'package:foosball_mobile_app/models/user/user_last_ten.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'loading.dart';

class DashBoardLastFive extends StatefulWidget {
  DashBoardLastFive({Key? key, required this.userState}) : super(key: key);
  final UserState userState;

  @override
  _DashBoardLastFiveState createState() => _DashBoardLastFiveState();
}

class _DashBoardLastFiveState extends State<DashBoardLastFive> {
  // state
  late List<UserLastTen>? lastTenMatches;
  late Future<List<UserLastTen>?> userStatsFuture;

  @override
  void initState() {
    super.initState();
    userStatsFuture = getUserStatsData();
  }

  Future<List<UserLastTen>?> getUserStatsData() async {
    String token = this.widget.userState.token;
    User user = new User(token: token);
    var lastTenMatchesData = await user.getLastTenMatches();
    lastTenMatches = lastTenMatchesData;
    return lastTenMatchesData;
  }

  String getHeadline(UserLastTen userLastTenObject) {
    String result = "";

    if (userLastTenObject.typeOfMatchName == "SingleLeagueMatch") {
      result = userLastTenObject.opponentOneFirstName +
          " " +
          userLastTenObject.opponentOneLastName;
    } else if (userLastTenObject.typeOfMatchName == "DoubleLeagueMatch") {
      result =
          '${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName} ${userLastTenObject.opponentTwoFirstName} ${userLastTenObject.opponentTwoLastName}';
    } else if (userLastTenObject.typeOfMatchName == "FreehandMatch") {
      result = userLastTenObject.opponentOneFirstName +
          " " +
          userLastTenObject.opponentOneLastName;
    } else if (userLastTenObject.typeOfMatchName == "DoubleFreehandMatch") {
      result =
          '${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName} ${userLastTenObject.opponentTwoFirstName} ${userLastTenObject.opponentTwoLastName}';
    }

    return result;
  }

  String getScore(UserLastTen userLastTenObject) {
    return userLastTenObject.userScore.toString() +
        ' - ' +
        userLastTenObject.opponentUserOrTeamScore.toString();
  }

  Color? getColorOfMatch(UserLastTen userLastTenObject) {
    Color? result;
    if (userLastTenObject.userScore >
        userLastTenObject.opponentUserOrTeamScore) {
      result = Colors.green[400];
    } else {
      result = Colors.red[400];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: userStatsFuture,
      builder: (context, AsyncSnapshot<List<UserLastTen>?> snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
              child: ListView.builder(
            itemCount: lastTenMatches!.length,
            itemBuilder: (context, index) {
              String headline = getHeadline(lastTenMatches![index]);
              String score = getScore(lastTenMatches![index]);
              Color? colorOfMatch = getColorOfMatch(lastTenMatches![index]);
              String formattedDate = DateFormat('dd-MM-yyyy | kk:mm')
                  .format(lastTenMatches![index].dateOfGame);
              String wonOrLostSymbol =
                  colorOfMatch == Colors.green[400] ? 'W' : 'L';

              return Card(
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        wonOrLostSymbol,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: colorOfMatch,
                    ),
                    title: Text(headline),
                    subtitle: Text(formattedDate),
                    trailing: Text(score)),
              );
            },
          ));
        } else {
          return Loading();
        }
      },
    ));
  }
}
