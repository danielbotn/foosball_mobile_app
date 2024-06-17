import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single-league-match-update/single_league_match_update_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import 'package:ntp/ntp.dart';

class OngoingGameButton extends StatefulWidget {
  final UserState userState;
  final bool gameStarted;
  final int matchId;
  final Function(bool gameStarted) startGameFunction;
  const OngoingGameButton(
      {super.key,
      required this.userState,
      required this.gameStarted,
      required this.matchId,
      required this.startGameFunction});

  @override
  State<OngoingGameButton> createState() => _OngoingGameButtonState();
}

class _OngoingGameButtonState extends State<OngoingGameButton> {
  // State
  bool loading = false;
  bool hasGameStarted = false;

  Future<bool> startMatch() async {
    setState(() {
      loading = true;
    });
    SingleLeagueMatchApi api = SingleLeagueMatchApi();
    SingleLeagueMatchUpdateModel newMatch = SingleLeagueMatchUpdateModel(
        startTime: await NTP.now(),
        endTime: null,
        playerOneScore: 0,
        playerTwoScore: 0,
        matchStarted: true,
        matchEnded: false,
        matchPaused: false);

    bool updateSuccessfull =
        await api.updateSingleLeagueMatch(widget.matchId, newMatch);
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
  void initState() {
    super.initState();
    setState(() {
      hasGameStarted = widget.gameStarted;
    });
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
