import 'package:flutter/material.dart';
import 'package:dano_foosball/models/single-league-goals/single_league_goal_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import '../extended_Text.dart';

class SingleLeagueGoals extends StatelessWidget {
  final UserState userState;
  final List<SingleLeagueGoalModel?> singleLeagueGoals;
  const SingleLeagueGoals(
      {Key? key, required this.userState, required this.singleLeagueGoals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: 290,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: singleLeagueGoals.length,
            itemBuilder: (context, index) {
              String score =
                  "${singleLeagueGoals[index]!.scorerScore}-${singleLeagueGoals[index]!.opponentScore}";
              String scoredByName =
                  "${singleLeagueGoals[index]!.scoredByUserFirstName} ${singleLeagueGoals[index]!.scoredByUserLastName}";
              String timeOfGoal =
                  singleLeagueGoals[index]!.goalTimeStopWatch.toString();
              return ListTile(
                  leading: ExtendedText(text: score, userState: userState),
                  title: ExtendedText(text: scoredByName, userState: userState),
                  trailing: ExtendedText(
                      text: timeOfGoal,
                      userState: userState,
                      colorOverride: AppColors.textGrey));
            },
          ),
        ));
  }
}
