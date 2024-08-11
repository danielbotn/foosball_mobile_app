import 'package:flutter/material.dart';
import 'package:dano_foosball/api/DoubleLeagueMatchApi.dart';
import 'package:dano_foosball/models/double-league-matches/double_league_match_update_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:ntp/ntp.dart';

class OnGoingDoubleGameButton extends StatefulWidget {
  final UserState userState;
  final bool gameStarted;
  final int matchId;
  final Function(bool gameStarted) startGameFunction;

  const OnGoingDoubleGameButton({
    Key? key,
    required this.userState,
    required this.gameStarted,
    required this.matchId,
    required this.startGameFunction,
  }) : super(key: key);

  @override
  State<OnGoingDoubleGameButton> createState() =>
      _OnGoingDoubleGameButtonState();
}

class _OnGoingDoubleGameButtonState extends State<OnGoingDoubleGameButton> {
  // State
  bool loading = false;
  bool hasGameStarted = false;

  Future<void> startMatch() async {
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
      matchPaused: false,
    );

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
                onPressed: widget.gameStarted ? null : startMatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.userState.darkmode
                      ? AppColors.darkModeButtonColor
                      : AppColors.buttonsLightTheme,
                  minimumSize: const Size(100, 50),
                ),
                child: ExtendedText(
                  text: hasGameStarted
                      ? widget.userState.hardcodedStrings.pause
                      : widget.userState.hardcodedStrings.startGame,
                  userState: widget.userState,
                  colorOverride: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
