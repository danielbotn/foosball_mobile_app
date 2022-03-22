import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandGoalsApi.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:foosball_mobile_app/models/other/freehandMatchDetailObject.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

import '../extended_Text.dart';

class MatchDetails extends StatefulWidget {
  final FreehandMatchDetailObject freehandMatchDetailObject;
  MatchDetails({Key? key, required this.freehandMatchDetailObject})
      : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  late Future<List<FreehandGoalsModel>?> goalsFuture;
  Helpers helpers = Helpers();

  @override
  void initState() {
    super.initState();
    goalsFuture = getFreehandGoals(
        widget.freehandMatchDetailObject.freehandMatchCreateResponse!.id);
  }

  Future<List<FreehandGoalsModel>?> getFreehandGoals(int matchId) async {
    FreehandGoalsApi freehandGoalsApi = new FreehandGoalsApi(
        token: widget.freehandMatchDetailObject.userState.token);
    var freehandGoals = await freehandGoalsApi.getFreehandGoals(matchId);
    return freehandGoals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(
              text: widget
                  .freehandMatchDetailObject.userState.hardcodedStrings.newGame,
              userState: widget.freehandMatchDetailObject.userState),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helpers.getIconTheme(
              widget.freehandMatchDetailObject.userState.darkmode),
          backgroundColor: helpers.getBackgroundColor(
              widget.freehandMatchDetailObject.userState.darkmode)),
      body: FutureBuilder(
        future: goalsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
