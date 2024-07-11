import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/UI/Error/ServerError.dart';
import 'package:foosball_mobile_app/widgets/emptyData/emptyData.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import 'package:foosball_mobile_app/widgets/new_game/new_game_oppositions_left.dart';
import 'package:foosball_mobile_app/widgets/new_game/new_game_vs.dart';
import 'package:foosball_mobile_app/widgets/new_game/start_game_button.dart';
import '../extended_Text.dart';
import '../headline_big.dart';
import '../headline_big_teammates_opponents.dart';
import 'new_game_buttons.dart';
import 'new_game_oppostions_right.dart';
import 'new_game_players.dart';

class NewGame extends StatefulWidget {
  final UserState userState;
  const NewGame({Key? key, required this.userState}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  late Future<List<UserResponse>?> usersFuture;
  String randomString = '';
  final newGameState = NewGameState(); // Instantiate the store

  @override
  void initState() {
    super.initState();
    usersFuture = getAllUsers();
  }

  Future<List<UserResponse>?> getAllUsers() async {
    UserApi userApi = UserApi();
    var users = await userApi.getUsers();

    if (users!.isEmpty) {
      return null;
    }

    return users;
  }

  void setRandomString() {
    Helpers helpers = Helpers();
    setState(() {
      randomString = helpers.generateRandomString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(
              text: widget.userState.hardcodedStrings.newGame,
              userState: widget.userState),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helpers.getIconTheme(widget.userState.darkmode),
          backgroundColor:
              helpers.getBackgroundColor(widget.userState.darkmode)),
      body: FutureBuilder(
          future: usersFuture,
          builder: (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display loading widget while waiting for the future
              return Center(child: Loading(userState: widget.userState));
            } else if (snapshot.hasError) {
              // Handle error case
              return ServerError(userState: widget.userState);
            } else if (!snapshot.hasData) {
              // Display message to the user if snapshot has no data
              return Container(
                  color: helpers.getBackgroundColor(widget.userState.darkmode),
                  child: EmptyData(
                      userState: widget.userState,
                      message: widget.userState.hardcodedStrings.noData,
                      iconData: Icons.error));
            } else if (snapshot.hasData) {
              // If data is available, build your UI with the data
              return Container(
                color: helpers.getBackgroundColor(widget.userState.darkmode),
                child: Theme(
                  data: widget.userState.darkmode
                      ? ThemeData.dark()
                      : ThemeData.light(),
                  child: Column(
                    children: <Widget>[
                      NewGameButtons(
                          userState: widget.userState,
                          notifyParent: setRandomString,
                          newGameState: newGameState),
                      HeadlineBigTeammatesOpponents(
                        userState: widget.userState,
                        fontSize: 20,
                        paddingLeft: 10,
                        randomString: '',
                        newGameState: newGameState,
                      ),
                      NewGamePlayers(
                          userState: widget.userState,
                          players: snapshot.data,
                          notifyParent: setRandomString,
                          newGameState: newGameState),
                      HeadlineBig(
                          headline: widget.userState.hardcodedStrings.match,
                          userState: widget.userState,
                          fontSize: 20,
                          paddingLeft: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          NewGameOppostionsLeft(
                            userState: widget.userState,
                            newGameState: newGameState,
                          ),
                          NewGameVs(
                            newGameState: newGameState,
                          ),
                          NewGameOppostionsRight(
                            userState: widget.userState,
                            newGameState: newGameState,
                          )
                        ],
                      ),
                      const Spacer(),
                      StartGameButton(
                        userState: widget.userState,
                        newGameState: newGameState,
                        buttonText: widget.userState.hardcodedStrings.startGame,
                      )
                    ],
                  ),
                ),
              );
            } else {
              // Default case, show an empty container
              return Container();
            }
          }),
    );
  }
}
