import 'package:flutter/material.dart';
import 'package:dano_foosball/api/UserApi.dart';
import 'package:dano_foosball/models/user/user_last_ten.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:dano_foosball/widgets/double_league_history/double_league_match_detail.dart';
import 'package:dano_foosball/widgets/single_league_history/single_league_match_detail.dart';
import 'package:dano_foosball/widgets/freehand_double_history/freehand_double_match_detail.dart';
import 'package:dano_foosball/widgets/freehand_history/freehand_match_detail.dart';
import 'package:dano_foosball/models/other/TwoPlayersObject.dart';
import 'package:intl/intl.dart';

class DashBoardLastFive extends StatefulWidget {
  const DashBoardLastFive({super.key, required this.userState});
  final UserState userState;

  @override
  State<DashBoardLastFive> createState() => _DashBoardLastFiveState();
}

class _DashBoardLastFiveState extends State<DashBoardLastFive> {
  late Future<List<UserLastTen>?> userStatsFuture;

  @override
  void initState() {
    super.initState();
    userStatsFuture = getUserStatsData();
  }

  Future<List<UserLastTen>?> getUserStatsData() async {
    UserApi user = UserApi();
    return await user.getLastTenMatches();
  }

  String getHeadline(UserLastTen userLastTenObject) {
    switch (userLastTenObject.typeOfMatchName) {
      case "SingleLeagueMatch":
      case "FreehandMatch":
        return "${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName}";
      case "DoubleLeagueMatch":
        return '${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName} ${userLastTenObject.opponentTwoFirstName} ${userLastTenObject.opponentTwoLastName}';
      case "DoubleFreehandMatch":
        String? opponentTwoFirstName = userLastTenObject.opponentTwoFirstName;
        String? opponentTwoLastName = userLastTenObject.opponentTwoLastName;
        return '${userLastTenObject.opponentOneFirstName} ${userLastTenObject.opponentOneLastName} $opponentTwoFirstName $opponentTwoLastName';
      default:
        return "";
    }
  }

  String getScore(UserLastTen userLastTenObject) {
    return '${userLastTenObject.userScore} - ${userLastTenObject.opponentUserOrTeamScore}';
  }

  Color? getColorOfMatch(UserLastTen userLastTenObject) {
    return userLastTenObject.userScore >
            userLastTenObject.opponentUserOrTeamScore
        ? AppColors.primary
        : AppColors.losingRed;
  }

  void navigateToHistoryDetails(UserLastTen data) {
    TwoPlayersObject tpo = TwoPlayersObject(
      userState: widget.userState,
      typeOfMatch: data.typeOfMatch.toString(),
      matchId: data.matchId,
    );
    Widget destination;
    switch (data.typeOfMatch) {
      case 0:
        destination = FreehandMatchDetail(twoPlayersObject: tpo);
        break;
      case 1:
        destination = FreehandDoubleMatchDetail(twoPlayersObject: tpo);
        break;
      case 2:
        tpo.leagueId = data.leagueId;
        destination = SingleLeagueMatchDetail(twoPlayersObject: tpo);
        break;
      case 3:
        tpo.leagueId = data.leagueId;
        destination = DoubleLeagueMatchDetail(twoPlayersObject: tpo);
        break;
      default:
        return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserLastTen>?>(
      future: userStatsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading(userState: widget.userState);
        } else if (snapshot.hasError) {
          return ServerError(userState: widget.userState);
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            children: snapshot.data!.map((match) {
              String headline = getHeadline(match);
              String score = getScore(match);
              Color? colorOfMatch = getColorOfMatch(match);
              String formattedDate =
                  DateFormat('dd-MM-yyyy | kk:mm').format(match.dateOfGame);
              String wonOrLostSymbol =
                  colorOfMatch == Colors.green[400] ? 'W' : 'L';

              return Card(
                elevation: 0,
                color: widget.userState.darkmode
                    ? AppColors.darkModeBackground
                    : AppColors.white,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  onTap: () => navigateToHistoryDetails(match),
                  leading: CircleAvatar(
                    backgroundColor: colorOfMatch,
                    child: Text(
                      wonOrLostSymbol,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(headline),
                  subtitle: Text(formattedDate),
                  trailing: Text(score),
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(child: Text('No matches found'));
        }
      },
    );
  }
}
