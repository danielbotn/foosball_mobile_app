import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import '../extended_Text.dart';

class FreehandDoubleGoals extends StatelessWidget {
  final UserState userState;
  final List<FreehandDoubleGoalModel>? freehandGoals;
  const FreehandDoubleGoals(
      {Key? key, required this.userState, required this.freehandGoals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: freehandGoals?.length ?? 0,
        itemBuilder: (context, index) {
          String score =
              "${freehandGoals![index].scorerTeamScore}-${freehandGoals![index].opponentTeamScore}";
          String scoredByName =
              "${freehandGoals![index].firstName} ${freehandGoals![index].lastName}";
          String timeOfGoal = freehandGoals![index].goalTimeStopWatch;
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
