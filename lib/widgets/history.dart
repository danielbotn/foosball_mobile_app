import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/HistoryApi.dart';
import 'package:foosball_mobile_app/models/history/historyModel.dart';
import 'package:foosball_mobile_app/models/history/userStats.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/single_league_history/single_league_match_detail.dart';
import 'package:intl/intl.dart';

import 'freehand_history/freehand_match_detail.dart';


class History extends StatefulWidget {
  final UserState userState;
  History({Key? key, required this.userState}) : super(key: key);

  @override
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
    HistoryApi hapi = new HistoryApi(token: this.widget.userState.token);
    var stats = await hapi.getStats();
    return stats;
  }

  Future<List<HistoryModel?>> getHistory() async {
    HistoryApi hapi = new HistoryApi(token: this.widget.userState.token);
    var history = await hapi.getHistory(pageNumber, pageSize);

    if (history.length > 0) {
      setState(() {
        historylist.addAll(history);
      });
    }

    return history;
  }

  _goToMatchDetailScreen(int matchId, String typeOfMatch) {
    TwoPlayersObject tpo = new TwoPlayersObject(
      userState: this.widget.userState,
      typeOfMatch: typeOfMatch,
      matchId: matchId,
    );

    if (typeOfMatch == "FreehandMatch") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FreehandMatchDetail(
                    twoPlayersObject: tpo,
                  )));
    }
    else if(typeOfMatch == "SingleLeagueMatch") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleLeagueMatchDetail(
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
        opponentTwoName = (history[i]!.opponentTwoFirstName!) +
            " " +
            (history[i]!.opponentTwoLastName!);
      } else {
        opponentTwoName = "";
      }

      list.add(ListTile(
        onTap: () => _goToMatchDetailScreen(
            history[i]!.matchId, history[i]!.typeOfMatchName),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                history[i]!.opponentOneFirstName.toString() +
                    " " +
                    history[i]!.opponentOneLastName.toString(),
                style: TextStyle(
                    color: this.widget.userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack)),
            Visibility(
              visible: opponentTwoName.isNotEmpty,
              child: Text(
                opponentTwoName,
                style: TextStyle(
                    color: this.widget.userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack),
              ),
            ),
          ],
        ),
        subtitle: Text(formattedDate,
            style: TextStyle(
                color: this.widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textBlack)),
        leading: SizedBox(
            height: 100,
            width: 50,
            child: Image.network(history[i]!.opponentOnePhotoUrl)),
        trailing: Container(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                      history[i]!.userScore.toString() +
                          " - " +
                          history[i]!.opponentUserOrTeamScore.toString(),
                      style: TextStyle(
                          color: this.widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.textBlack)),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              winner == true
                  ? Text(this.widget.userState.hardcodedStrings.won, style: TextStyle(color: Colors.green))
                  : Text(this.widget.userState.hardcodedStrings.lost, style: TextStyle(color: Colors.red)),
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
          title: Text(this.widget.userState.hardcodedStrings.history, style : TextStyle(color: this.widget.userState.darkmode ? AppColors.white : AppColors.textBlack)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: this.widget.userState.darkmode
              ? IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: this.widget.userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white),
      body: FutureBuilder(
        future: Future.wait([statsFuture, historyFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var one = snapshot.data![0]; //stats
            var two = snapshot.data![1]; //history
            return Container(
              color: this.widget.userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              // add listview with variable two
              child: ListView(
                controller: _controller,
                padding: const EdgeInsets.all(8),
                children: _buildHistoryList(historylist),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
