import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
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

  // used to rebuild widget
  refresh() {
    setState(() {});
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
                    ),
                    Spacer(),
                    OngoingButtons(counter: counter, notifyParent: refresh),
                  ],
                ))));
  }
}
