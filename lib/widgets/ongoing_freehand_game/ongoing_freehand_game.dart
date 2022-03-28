import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/player_card.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/player_score.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/time_keeper.dart';
import 'package:provider/provider.dart';
import '../extended_Text.dart';
import 'ongoing_buttons.dart';

class OngoingFreehandGame extends StatefulWidget {
  final OngoingGameObject ongoingGameObject;
  OngoingFreehandGame({Key? key, required this.ongoingGameObject})
      : super(key: key);

  @override
  State<OngoingFreehandGame> createState() => _OngoingFreehandGameState();
}

class _OngoingFreehandGameState extends State<OngoingFreehandGame> {
  final OngoingFreehandState counter = OngoingFreehandState();
  String randomString = '';
  String randomStringStopClock = '';

  // used to rebuild widget
  void refresh() {
    setState(() {});
    setRandomString();
  }

  void refreshScoreWidget() {
    setState(() {});
  }

  void setRandomString() {
    Helpers helpers = Helpers();
    var randomString = helpers.generateRandomString();
    setState(() {
      this.randomString = randomString;
    });
  }

  void stopClockFromChild() {
    setRandomStringStopClock();
  }

  void setRandomStringStopClock() {
    Helpers helpers = Helpers();
    var randomString = helpers.generateRandomString();
    setState(() {
      this.randomStringStopClock = randomString;
    });
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: userState.hardcodedStrings.newGame, userState: userState),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(userState.darkmode),
            backgroundColor: helpers.getBackgroundColor(userState.darkmode)),
        body: Provider<OngoingFreehandState>(
            create: (_) => OngoingFreehandState(),
            child: Container(
                color: helpers.getBackgroundColor(userState.darkmode),
                child: Column(
                  children: [
                    TimeKeeper(
                        ongoingGameObject: widget.ongoingGameObject,
                        counter: counter,
                        randomString: randomString,
                        randomStringStopClock: randomStringStopClock),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: PlayerCard(
                            ongoingGameObject: widget.ongoingGameObject,
                            userState: userState,
                            isPlayerOne: true,
                            counter: counter,
                            notifyParent: refreshScoreWidget,
                            stopClockFromChild: stopClockFromChild,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: PlayerScore(
                                userState: userState,
                                isPlayerOne: true,
                                counter: counter))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: PlayerCard(
                            ongoingGameObject: widget.ongoingGameObject,
                            userState: userState,
                            isPlayerOne: false,
                            counter: counter,
                            notifyParent: refreshScoreWidget,
                            stopClockFromChild: stopClockFromChild,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: PlayerScore(
                                userState: userState,
                                isPlayerOne: false,
                                counter: counter))
                      ],
                    ),
                    Spacer(),
                    OngoingButtons(
                        counter: counter,
                        notifyParent: refresh,
                        userState: userState),
                  ],
                ))));
  }
}
