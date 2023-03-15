import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class LeagueList extends StatelessWidget {
  final UserState userState;
  final String randomNumber;
  final List<GetLeagueResponse?>? data;

  const LeagueList(
      {Key? key,
      required this.userState,
      this.data,
      required this.randomNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const SizedBox();
    }

    return SafeArea(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final league = data![index];
        if (league == null) {
          return const SizedBox();
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: userState.darkmode
                ? AppColors.lightThemeShadowColor
                : AppColors.buttonsLightTheme,
            child: ExtendedText(
              text: '${index + 1}',
              userState: userState,
              colorOverride: AppColors.white,
            ),
          ),
          title: ExtendedText(
            text: league.name,
            userState: userState,
          ),
          subtitle: league.hasLeagueStarted ? null : const Text('Not Started'),
        );
      },
    ));
  }
}
