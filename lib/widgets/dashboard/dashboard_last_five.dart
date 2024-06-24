import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/UI/Error/ServerError.dart';
import 'package:foosball_mobile_app/widgets/double_league_history/double_league_match_detail.dart';
import 'package:foosball_mobile_app/widgets/single_league_history/single_league_match_detail.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/user/user_last_ten.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

import '../../models/other/TwoPlayersObject.dart';
import '../freehand_double_history/freehand_double_match_detail.dart';
import '../freehand_history/freehand_match_detail.dart';

class DashBoardLastFive extends StatefulWidget {
  const DashBoardLastFive({Key? key, required this.userState})
      : super(key: key);
  final UserState userState;

  @override
  State<DashBoardLastFive> createState() => _DashBoardLastFiveState();
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
    UserApi user = UserApi();
    var lastTenMatchesData = await user.getLastTenMatches();
    lastTenMatches = lastTenMatchesData;
    return lastTenMatchesData;
  }

  String getHeadline(UserLastTen userLastTenObject) {
    String result = "";

    if (userLastTenObject.typeOfMatchName == "SingleLeagueMatch") {
      result =
          "${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName}";
    } else if (userLastTenObject.typeOfMatchName == "DoubleLeagueMatch") {
      result =
          '${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName} ${userLastTenObject.opponentTwoFirstName} ${userLastTenObject.opponentTwoLastName}';
    } else if (userLastTenObject.typeOfMatchName == "FreehandMatch") {
      result =
          "${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName}";
    } else if (userLastTenObject.typeOfMatchName == "DoubleFreehandMatch") {
      String? oponentTwoFirstName, oponentTwoLastName;
      if (userLastTenObject.opponentTwoFirstName != null) {
        oponentTwoFirstName = userLastTenObject.opponentTwoFirstName;
      }
      if (userLastTenObject.opponentTwoLastName != null) {
        oponentTwoLastName = userLastTenObject.opponentTwoLastName;
      }
      result =
          '${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName} $oponentTwoFirstName $oponentTwoLastName';
    }

    return result;
  }

  String getScore(UserLastTen userLastTenObject) {
    return '${userLastTenObject.userScore} - ${userLastTenObject.opponentUserOrTeamScore}';
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

  void navigateToHistoryDetails(UserLastTen data) {
    TwoPlayersObject tpo = TwoPlayersObject(
      userState: widget.userState,
      typeOfMatch: data.typeOfMatch.toString(),
      matchId: data.matchId,
    );
    if (data.typeOfMatch == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FreehandMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    } else if (data.typeOfMatch == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FreehandDoubleMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    } else if (data.typeOfMatch == 2) {
      // Go to SingleLeagueMatchDetail
      tpo.leagueId = data.leagueId;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleLeagueMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    } else if (data.typeOfMatch == 3) {
      // Go to DoubleLeagueMatchDetail
      tpo.leagueId = data.leagueId;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoubleLeagueMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserLastTen>?>(
      future: userStatsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading(
            userState: widget.userState,
          );
        } else if (snapshot.hasError) {
          // Handle errors here
          return ServerError(userState: widget.userState);
        } else if (snapshot.hasData) {
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
                  color: widget.userState.darkmode
                      ? AppColors.darkModeBackground
                      : AppColors.white,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    onTap: () {
                      navigateToHistoryDetails(lastTenMatches![index]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: colorOfMatch,
                      child: Text(
                        wonOrLostSymbol,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(headline),
                    subtitle: Text(formattedDate),
                    trailing: Text(score),
                  ),
                );
              },
            ),
          );
        } else {
          return Loading(
            userState: widget.userState,
          );
        }
      },
    );
  }
}
