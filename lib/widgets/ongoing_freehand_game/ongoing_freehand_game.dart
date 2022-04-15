import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/player_card.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/player_score.dart';
import 'package:foosball_mobile_app/widgets/ongoing_freehand_game/time_keeper.dart';
import 'package:provider/provider.dart';
import '../Dashboard.dart';
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

  void closeAlertDialog() {
    // delete freehand game and goals and then navigate back to dashboard
    FreehandMatchApi freehandMatchApi =
        new FreehandMatchApi(token: widget.ongoingGameObject.userState.token);
    freehandMatchApi
        .deleteFreehandMatch(
            widget.ongoingGameObject.freehandMatchCreateResponse!.id)
        .then((value) {
      if (value == true) {
        // go to dashboard screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      param: widget.ongoingGameObject.userState,
                    )));
      }
    });
  }

  Future<void> showAlertModal(BuildContext context) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(widget
                .ongoingGameObject.userState.hardcodedStrings.areYouSureAlert),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 'Yes');
                    },
                    child: Text(widget
                        .ongoingGameObject.userState.hardcodedStrings.yes),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 'No');
                    },
                    child: Text(
                        widget.ongoingGameObject.userState.hardcodedStrings.no),
                  ),
                ],
              )
            ],
          );
        })) {
      case 'Yes':
        stopClockFromChild();
        closeAlertDialog();
        break;
      case 'No':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: userState.hardcodedStrings.newGame, userState: userState),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                showAlertModal(context);
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
