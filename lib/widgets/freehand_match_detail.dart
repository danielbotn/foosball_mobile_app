import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandGoalsApi.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

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

    if (this.widget.twoPlayersObject.typeOfMatch == "FreehandMatch") {
    } else if (this.widget.twoPlayersObject.typeOfMatch ==
        "SingleLeagueMatch") {}

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
    var freehandMatch = await fmapi.getFreehandMatch(
        this.widget.twoPlayersObject.matchId);
    return freehandMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('History'),
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
        future: Future.wait([freehandGoalsFuture, userFuture, freehandMatchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var freehandGoals = snapshot.data![0] as List<FreehandGoalsModel>?; //freehand goals
            var userInfo = snapshot.data![1] as UserResponse; //user info
            var freehandMatch = snapshot.data![2] as FreehandMatchModel?; //freehand match

            String oponentFirstName, oponentLastName, oponentPhotoUrl = "";

            if (freehandMatch!.playerOneId == userInfo.id) {
              oponentFirstName = freehandMatch.playerTwoFirstName;
              oponentLastName = freehandMatch.playerTwoLastName;
              oponentPhotoUrl = freehandMatch.playerTwoPhotoUrl;
            } else {
              oponentFirstName = freehandMatch.playerOneFirstName;
              oponentLastName = freehandMatch.playerOneLastName;
              oponentPhotoUrl = freehandMatch.playerOnePhotoUrl;
            }

            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(children: [
                      Column(children: [
                        Image.network(userInfo.photoUrl, width: 80, height: 80),
                      ],),
                       Column(children: [
                        Text(userInfo.firstName),
                        Text(userInfo.lastName),
                      ],)
                    ],)
                  ],
                ),
              Column(
                  children: [
                    Row(children: [
                     
                       Column(children: [
                        Text(oponentFirstName),
                        Text(oponentLastName)
                      ],),
                       Column(children: [
                        Image.network(oponentPhotoUrl, width: 80, height: 80),
                      ],),
                    ],)
                  ],
                ),
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
