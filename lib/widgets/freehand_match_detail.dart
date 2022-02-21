import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandGoalsApi.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

import 'freehand_match_card.dart';
import 'freehand_match_score.dart';
import 'freehand_match_total_playing_time.dart';

class FreehandMatchDetail extends StatefulWidget {
  // props
  final TwoPlayersObject twoPlayersObject;
  FreehandMatchDetail({
    Key? key,
    required this.twoPlayersObject,
  }) : super(key: key);

  @override
  _FreehandMatchDetailState createState() => _FreehandMatchDetailState();
}

class _FreehandMatchDetailState extends State<FreehandMatchDetail> {
  // State variables
  late Future<List<FreehandGoalsModel>?> freehandGoalsFuture;
  late Future<UserResponse> userFuture;
  late Future<FreehandMatchModel?> freehandMatchFuture;

  @override
  void initState() {
    super.initState();

    freehandGoalsFuture = getFreehandGoals();
    userFuture = getUser();
    freehandMatchFuture = getFreehandMatch();
  }

  Future<List<FreehandGoalsModel>?> getFreehandGoals() async {
    print('this.widget.twoPlayersObject.matchId)');
    print(this.widget.twoPlayersObject.matchId);
    FreehandGoalsApi fgapi = new FreehandGoalsApi(
        token: this.widget.twoPlayersObject.userState.token);
    var freehandGoals =
        await fgapi.getFreehandGoals(this.widget.twoPlayersObject.matchId);
    return freehandGoals;
  }

  Future<UserResponse> getUser() async {
    UserApi uapi =
        new UserApi(token: this.widget.twoPlayersObject.userState.token);
    var user = await uapi
        .getUser(this.widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<FreehandMatchModel?> getFreehandMatch() async {
    FreehandMatchApi fmapi = new FreehandMatchApi(
        token: this.widget.twoPlayersObject.userState.token);
    var freehandMatch =
        await fmapi.getFreehandMatch(this.widget.twoPlayersObject.matchId);
    return freehandMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Match Details',
              style: TextStyle(
                  color: this.widget.twoPlayersObject.userState.darkmode
                      ? AppColors.white
                      : AppColors.textBlack)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: this.widget.twoPlayersObject.userState.darkmode
              ? IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: this.widget.twoPlayersObject.userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white),
      body: FutureBuilder(
        future:
            Future.wait([freehandGoalsFuture, userFuture, freehandMatchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var freehandGoals =
                snapshot.data![0] as List<FreehandGoalsModel>?; //freehand goals
            var userInfo = snapshot.data![1] as UserResponse; //user info
            var freehandMatch =
                snapshot.data![2] as FreehandMatchModel?; //freehand match

            String oponentFirstName,
                oponentLastName,
                oponentPhotoUrl,
                userScore,
                opponentScore = "";

            if (freehandMatch!.playerOneId == userInfo.id) {
              oponentFirstName = freehandMatch.playerTwoFirstName;
              oponentLastName = freehandMatch.playerTwoLastName;
              oponentPhotoUrl = freehandMatch.playerTwoPhotoUrl;
              userScore = freehandMatch.playerOneScore.toString();
              opponentScore = freehandMatch.playerTwoScore.toString();
            } else {
              oponentFirstName = freehandMatch.playerOneFirstName;
              oponentLastName = freehandMatch.playerOneLastName;
              oponentPhotoUrl = freehandMatch.playerOnePhotoUrl;
              userScore = freehandMatch.playerTwoScore.toString();
              opponentScore = freehandMatch.playerOneScore.toString();
            }

            return Container(
                color: this.widget.twoPlayersObject.userState.darkmode
                    ? AppColors.darkModeBackground
                    : AppColors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FreehandMatchCard(
                          userState: this.widget.twoPlayersObject.userState,
                          userFirstName: userInfo.firstName,
                          userLastName: userInfo.lastName,
                          userPhotoUrl: userInfo.photoUrl,
                          lefOrRight: true,
                        ),
                        FreehandMatchCard(
                          userState: this.widget.twoPlayersObject.userState,
                          userFirstName: oponentFirstName,
                          userLastName: oponentLastName,
                          userPhotoUrl: oponentPhotoUrl,
                          lefOrRight: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FreehandMatchScore(
                          userState: this.widget.twoPlayersObject.userState,
                          userScore: userScore,
                        ),
                        FreehandMatchScore(
                          userState: this.widget.twoPlayersObject.userState,
                          userScore: opponentScore,
                        ),
                      ],
                    ),
                    FreehandMatchTotalPlayingTime(
                      userState: this.widget.twoPlayersObject.userState,
                      totalPlayingTime: freehandMatch.totalPlayingTime.toString(),
                      totalPlayingTimeLabel: "Total Playing Time"),
                     
                  ],
                ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
