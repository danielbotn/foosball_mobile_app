import 'package:flutter/material.dart';
import 'package:dano_foosball/api/SingleLeagueMatchApi.dart';
import 'package:dano_foosball/models/single-league-matches/single-league-match-update/single_league_match_update_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:ntp/ntp.dart';

class OngoingGameButton extends StatefulWidget {
  final UserState userState;
  final bool gameStarted;
  final int matchId;
  final Function(bool gameStarted) startGameFunction;

  const OngoingGameButton({
    Key? key,
    required this.userState,
    required this.gameStarted,
    required this.matchId,
    required this.startGameFunction,
  }) : super(key: key);

  @override
  State<OngoingGameButton> createState() => _OngoingGameButtonState();
}

class _OngoingGameButtonState extends State<OngoingGameButton> {
  bool loading = false;
  bool hasGameStarted = false;

  @override
  void initState() {
    super.initState();
    // Initialize state based on the widget's gameStarted prop
    hasGameStarted = widget.gameStarted;
  }

  Future<void> startMatch() async {
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
      matchPaused: false,
    );

    bool updateSuccessful =
        await api.updateSingleLeagueMatch(widget.matchId, newMatch);
    setState(() {
      loading = false;
    });

    if (updateSuccessful) {
      widget.startGameFunction(updateSuccessful);
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
