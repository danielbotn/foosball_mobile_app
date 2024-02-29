import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/HistoryApi.dart';
import 'package:foosball_mobile_app/models/history/historyModel.dart';
import 'package:foosball_mobile_app/models/history/userStats.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/emptyData/emptyData.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import 'package:foosball_mobile_app/widgets/single_league_history/single_league_match_detail.dart';
import 'package:intl/intl.dart';

import 'double_league_history/double_league_match_detail.dart';
import 'freehand_double_history/freehand_double_match_detail.dart';
import 'freehand_history/freehand_match_detail.dart';

class History extends StatefulWidget {
  final UserState userState;
  const History({Key? key, required this.userState}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<UserStats?> statsFuture;
  late Future<List<HistoryModel?>> historyFuture;

  late ScrollController _controller;

  // State variables
  int pageNumber = 1;
  int pageSize = 50;
  List<HistoryModel?> historylist = [];

  _scrollListener() {
    // check if we're at the bottom of the scrollable view
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        pageNumber += 1;
      });
      historyFuture = getHistory();
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    statsFuture = getStats();
    historyFuture = getHistory();
  }

  Future<UserStats?> getStats() async {
    HistoryApi hapi = HistoryApi();
    var stats = await hapi.getStats();
    return stats;
  }

  Future<List<HistoryModel?>> getHistory() async {
    HistoryApi hapi = HistoryApi();
    var history = await hapi.getHistory(pageNumber, pageSize);

    if (history.isNotEmpty) {
      setState(() {
        historylist.addAll(history);
      });
    }

    return history;
  }

  SizedBox singleOrDoubleMatch(HistoryModel historyObject) {
    if (historyObject.typeOfMatchName == 'DoubleFreehandMatch' ||
        historyObject.typeOfMatchName == 'DoubleLeagueMatch') {
      String opponentTwoPhotoUrl = '';
      if (historyObject.opponentTwoPhotoUrl != null) {
        opponentTwoPhotoUrl = historyObject.opponentTwoPhotoUrl!;
      }
      return SizedBox(
          height: 55,
          width: 25,
          child: Column(
            children: [
              Image.network(historyObject.opponentOnePhotoUrl),
              Visibility(
                visible: opponentTwoPhotoUrl != '',
                child: Image.network(opponentTwoPhotoUrl),
              )
            ],
          ));
    } else {
      return SizedBox(
          height: 100,
          width: 50,
          child: Image.network(historyObject.opponentOnePhotoUrl));
    }
  }

  _goToMatchDetailScreen(int matchId, String typeOfMatch, int? leagueId) {
    TwoPlayersObject tpo = TwoPlayersObject(
        userState: widget.userState,
        typeOfMatch: typeOfMatch,
        matchId: matchId,
        leagueId: leagueId);

    if (typeOfMatch == "FreehandMatch") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FreehandMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    } else if (typeOfMatch == "SingleLeagueMatch") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleLeagueMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    } else if (typeOfMatch == "DoubleFreehandMatch") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FreehandDoubleMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoubleLeagueMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    }
  }

  List<ListTile> _buildHistoryList(List<HistoryModel?> history) {
    List<ListTile> list = <ListTile>[];
    for (var i = 0; i < history.length; i++) {
      bool winner = false;
      if (history[i]!.userScore > history[i]!.opponentUserOrTeamScore) {
        winner = true;
      } else {
        winner = false;
      }
      String formattedDate =
          DateFormat('dd-MM-yyyy | kk:mm').format(history[i]!.dateOfGame);

      String? opponentTwoName = "";

      if (history[i]!.opponentTwoFirstName != null &&
          history[i]!.opponentTwoFirstName != null) {
        opponentTwoName =
            "${history[i]!.opponentTwoFirstName!} ${history[i]!.opponentTwoLastName!}";
      } else {
        opponentTwoName = "";
      }

      list.add(ListTile(
        onTap: () => _goToMatchDetailScreen(history[i]!.matchId,
            history[i]!.typeOfMatchName, history[i]!.leagueId),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "${history[i]!.opponentOneFirstName} ${history[i]!.opponentOneLastName}",
                style: TextStyle(
                    color: this.widget.userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack)),
            Visibility(
              visible: opponentTwoName.isNotEmpty,
              child: Text(
                opponentTwoName,
                style: TextStyle(
                    color: widget.userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack),
              ),
            ),
          ],
        ),
        subtitle: Text(formattedDate,
            style: TextStyle(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textBlack)),
        leading: singleOrDoubleMatch(history[i]!),
        trailing: SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                      "${history[i]!.userScore} - ${history[i]!.opponentUserOrTeamScore}",
                      style: TextStyle(
                          color: widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.textBlack)),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              winner == true
                  ? Text(widget.userState.hardcodedStrings.won,
                      style: const TextStyle(color: Colors.green))
                  : Text(widget.userState.hardcodedStrings.lost,
                      style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.userState.hardcodedStrings.history,
              style: TextStyle(
                  color: widget.userState.darkmode
                      ? AppColors.white
                      : AppColors.textBlack)),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: widget.userState.darkmode
              ? const IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: widget.userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white),
      body: FutureBuilder(
        future: Future.wait([statsFuture, historyFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(
                userState: widget.userState); // Display loading widget
          } else if (snapshot.hasError) {
            // Display error message
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            // Extract history data from the snapshot
            List<dynamic>? historyData = snapshot.data![1];

            // Check if historyData is empty
            if (historyData == null || historyData.isEmpty) {
              // Display message if historyData is empty
              return Center(
                  child: EmptyData(
                      userState: widget.userState,
                      message: widget.userState.hardcodedStrings.noData,
                      iconData: Icons.person_off_sharp));
            } else {
              // Display your UI with the data
              return Container(
                color: widget.userState.darkmode
                    ? AppColors.darkModeBackground
                    : AppColors.white,
                child: ListView(
                  controller: _controller,
                  padding: const EdgeInsets.all(8),
                  children: _buildHistoryList(historylist),
                ),
              );
            }
          } else {
            // Default case, show an empty container
            return Container();
          }
        },
      ),
    );
  }
}
