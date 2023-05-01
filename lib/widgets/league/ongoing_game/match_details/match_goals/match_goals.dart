import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single_league_goal_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class MatchGoals extends StatelessWidget {
  final UserState userState;
  final List<SingleLeagueGoalModel>? goals;
  const MatchGoals({Key? key, required this.userState, required this.goals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: 290,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: goals?.length ?? 0,
            itemBuilder: (context, index) {
              String score =
                  "${goals![index].scorerScore}-${goals![index].opponentScore}";
              String scoredByName =
                  "${goals![index].scoredByUserFirstName} ${goals![index].scoredByUserLastName}";
              String timeOfGoal = goals![index].goalTimeStopWatch;
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
