import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeagueGoalApi.dart';
import 'package:foosball_mobile_app/api/SingleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single_league_goal_model.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

import '../extended_Text.dart';

class SingleLeagueMatchDetail extends StatefulWidget {
  // Props
  final TwoPlayersObject twoPlayersObject;
  SingleLeagueMatchDetail({Key? key, required this.twoPlayersObject}) : super(key: key);

  @override
  State<SingleLeagueMatchDetail> createState() => _SingleLeagueMatchDetailState();
}

class _SingleLeagueMatchDetailState extends State<SingleLeagueMatchDetail> {
  late Future<UserResponse> userFuture;
  late Future<SingleLeagueMatchModel?> singleLeagueMatchFuture;
  late Future<List<SingleLeagueGoalModel>?> singleLeagueGoalsFuture;

  SingleLeagueMatchModel? singleLeagueMatch;

  @override
  void initState() {
    super.initState();

    userFuture = getUser();
    singleLeagueMatchFuture = getSingleLeagueMatch();
    singleLeagueGoalsFuture = getSingleLeagueGoals();
  }

  Future<UserResponse> getUser() async {
    UserApi uapi =
        new UserApi(token: this.widget.twoPlayersObject.userState.token);
    var user = await uapi
        .getUser(this.widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<SingleLeagueMatchModel?> getSingleLeagueMatch() async {
    SingleLeagueMatchApi api = new SingleLeagueMatchApi(token: this.widget.twoPlayersObject.userState.token);
    var match = await api.getSingleLeagueMatchById(this.widget.twoPlayersObject.matchId);
    setState(() {
      singleLeagueMatch = match;
    });
    return match;
  }

  Future<List<SingleLeagueGoalModel>?> getSingleLeagueGoals() async {
    SingleLeagueGoalApi api = new SingleLeagueGoalApi(token: this.widget.twoPlayersObject.userState.token);
    var goals;
    singleLeagueMatchFuture.then((value) async => {
      if (singleLeagueMatch != null) {
        goals = await api.getSingleLeagueGoals(singleLeagueMatch!.leagueId, this.widget.twoPlayersObject.matchId)
      }
    });

    return goals;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helper = new Helpers();
    String matchDetails = this.widget.twoPlayersObject.userState.hardcodedStrings.matchDetails;
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(text: matchDetails, userState: userState),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helper.getIconTheme(userState.darkmode),
          backgroundColor: helper.getBackgroundColor(userState.darkmode)),
      body: FutureBuilder(
       future: Future.wait([
         userFuture, singleLeagueMatchFuture, singleLeagueGoalsFuture
         ]),
       builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            // var goals = snapshot.data![0] as List<SingleLeagueGoalModel>;
            // var user = snapshot.data![1] as UserResponse;
            // var match = snapshot.data![2] as SingleLeagueMatchModel;
            return Container(
              child: Text('gaur')
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
       }
      ),
    );
  }
}