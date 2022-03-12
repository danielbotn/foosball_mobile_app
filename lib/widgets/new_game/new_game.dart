import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/new_game/new_game_oppositions_left.dart';
import 'package:foosball_mobile_app/widgets/new_game/new_game_vs.dart';
import 'package:foosball_mobile_app/widgets/new_game/start_game_button.dart';
import 'package:provider/provider.dart';

import '../extended_Text.dart';
import '../headline_big.dart';
import 'new_game_buttons.dart';
import 'new_game_oppostions_right.dart';
import 'new_game_players.dart';

class NewGame extends StatefulWidget {
  final UserState userState;
  NewGame({Key? key, required this.userState}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  late Future<List<UserResponse>?> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = getAllUsers();
  }

  // Get hardcoded strings from datoCMS
  Future<List<UserResponse>?> getAllUsers() async {
    UserApi datoCMS = new UserApi(token: this.widget.userState.token);
    var users = await datoCMS.getUsers();
    return users;
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
      body: FutureBuilder(
          future: usersFuture,
          builder: (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
            if (snapshot.hasData) {
              return Provider<NewGameState>(
                  create: (_) => NewGameState(),
                  child: Container(
                      child: Theme(
                          data: userState.darkmode
                              ? ThemeData.dark()
                              : ThemeData.light(),
                          child: Column(children: <Widget>[
                            NewGameButtons(
                              userState: userState,
                            ),
                            HeadlineBig(
                                headline: 'Choose Players',
                                userState: userState,
                                fontSize: 20,
                                paddingLeft: 10),
                            NewGamePlayers(
                              userState: userState,
                              players: snapshot.data,
                            ),
                            HeadlineBig(
                                headline: 'Match',
                                userState: userState,
                                fontSize: 20,
                                paddingLeft: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                NewGameOppostionsLeft(
                                  userState: userState,
                                ),
                                NewGameVs(),
                                NewGameOppostionsRight(
                                  userState: userState,
                                )
                              ],
                            ),
                            Spacer(),
                            StartGameButton(
                              userState: userState,
                            )
                          ]))));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}