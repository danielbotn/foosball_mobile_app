import 'package:flutter/material.dart';
import 'package:dano_foosball/models/double-league-goals/double_league_goal_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import '../extended_Text.dart';

class DoubleLeagueGoals extends StatelessWidget {
  final UserState userState;
  final List<DoubleLeagueGoalModel>? goals;
  const DoubleLeagueGoals({
    Key? key,
    required this.userState,
    required this.goals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: goals?.length ?? 0,
        itemBuilder: (context, index) {
          String score =
              "${goals![index].scorerTeamScore}-${goals![index].opponentTeamScore}";
          String scoredByName =
              "${goals![index].scorerFirstName} ${goals![index].scorerLastName}";
          String timeOfGoal = goals![index].goalTimeStopWatch;
          return ListTile(
            leading: ExtendedText(text: score, userState: userState),
            title: ExtendedText(text: scoredByName, userState: userState),
            trailing: ExtendedText(
              text: timeOfGoal,
              userState: userState,
              colorOverride: AppColors.textGrey,
            ),
          );
        },
      ),
    );
  }
}
