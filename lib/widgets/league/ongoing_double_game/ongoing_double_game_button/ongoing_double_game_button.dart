import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/DoubleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_update_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import 'package:ntp/ntp.dart';

class OnGoingDoubleGameButton extends StatefulWidget {
  final UserState userState;
  final bool gameStarted;
  final int matchId;
  final Function(bool gameStarted) startGameFunction;
  const OnGoingDoubleGameButton(
      {super.key,
      required this.userState,
      required this.gameStarted,
      required this.matchId,
      required this.startGameFunction});

  @override
  State<OnGoingDoubleGameButton> createState() =>
      _OnGoingDoubleGameButtonState();
}

class _OnGoingDoubleGameButtonState extends State<OnGoingDoubleGameButton> {
  // State
  bool loading = false;
  bool hasGameStarted = false;

  Future<bool> startMatch() async {
    setState(() {
      loading = true;
    });
    DoubleLeagueMatchApi api = DoubleLeagueMatchApi();
    DoubleLeagueMatchUpdateModel newMatch = DoubleLeagueMatchUpdateModel(
        startTime: await NTP.now(),
        endTime: null,
        teamOneScore: 0,
        teamTwoScore: 0,
        matchStarted: true,
        matchEnded: false,
        matchPaused: false);

    bool updateSuccessfull =
        await api.updateDoubleLeagueMatch(widget.matchId, newMatch);
    setState(() {
      loading = false;
    });
    if (updateSuccessfull) {
      widget.startGameFunction(updateSuccessfull);
      setState(() {
        hasGameStarted = true;
      });
    }
    return updateSuccessfull;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading(userState: widget.userState);
    } else {
      return Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () => {
                    if (widget.gameStarted == false) {startMatch()}
                  },
                  style: ElevatedButton.styleFrom(
                      primary: widget.userState.darkmode
                          ? AppColors.darkModeButtonColor
                          : AppColors.buttonsLightTheme,
                      minimumSize: const Size(100, 50)),
                  child: ExtendedText(
                    text: hasGameStarted == false
                        ? widget.userState.hardcodedStrings.startGame
                        : widget.userState.hardcodedStrings.pause,
                    userState: widget.userState,
                    colorOverride: AppColors.white,
                  ),
                ),
              )),
        ],
      );
    }
  }
}
