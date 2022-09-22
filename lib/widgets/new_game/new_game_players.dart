import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class NewGamePlayers extends StatefulWidget {
  final UserState userState;
  final List<UserResponse>? players;
  final Function() notifyParent;
  final NewGameState newGameState;
  const NewGamePlayers(
      {Key? key,
      required this.userState,
      required this.players,
      required this.notifyParent,
      required this.newGameState})
      : super(key: key);

  @override
  State<NewGamePlayers> createState() => _NewGamePlayersState();
}

class _NewGamePlayersState extends State<NewGamePlayers> {
  Helpers helpers = Helpers();
  List<ListTile> _buildPlayersList(
      List<UserResponse>? users, NewGameState gameState) {
    List<ListTile> list = <ListTile>[];
    for (var i = 0; i < users!.length; i++) {
      list.add(ListTile(
        // onTap: () => _goToMatchDetailScreen(
        //     history[i]!.matchId, history[i]!.typeOfMatchName, history[i]!.leagueId),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${users[i].firstName} ${users[i].lastName}"),
          ],
        ),
        subtitle: Text(users[i].email),
        leading: SizedBox(
            height: 100, width: 50, child: Image.network(users[i].photoUrl)),
        trailing: SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Visibility(
                    visible: true,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor:
                          helpers.getCheckMarkColor(userState.darkmode),
                      value: gameState.checkedPlayers[i].item2,
                      onChanged: (bool? value) {
                        if (isCheckedLoggedInUser(value, i, users[i]) ==
                            false) {
                          checkBoxChecked(value, i, users[i]);
                          widget.notifyParent();
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  bool isCheckedLoggedInUser(bool? value, int index, UserResponse user) {
    bool result = false;
    if (user.id == userState.userId) {
      result = true;
    }
    return result;
  }

  void checkBoxChecked(bool? value, int index, UserResponse user) {
    bool isChecked = value ?? false;

    if (isChecked) {
      if (widget.newGameState.twoOrFourPlayers) {
        if (widget.newGameState.playersTeamOne.isEmpty ||
            widget.newGameState.playersTeamTwo.isEmpty) {
          widget.newGameState.setCheckedPlayer(index, isChecked, user.id);
          setTeamsInStore(isChecked, index, user);
        }
      } else {
        if (widget.newGameState.playersTeamOne.length < 2 ||
            widget.newGameState.playersTeamTwo.length < 2) {
          widget.newGameState.setCheckedPlayer(index, isChecked, user.id);
          setTeamsInStore(isChecked, index, user);
        }
      }
    } else {
      widget.newGameState.setCheckedPlayer(index, isChecked, user.id);
      setTeamsInStore(isChecked, index, user);
    }
  }

  void setTeamsInStore(bool value, int index, UserResponse user) {
    if (value) {
      // two players
      if (widget.newGameState.twoOrFourPlayers) {
        if (widget.newGameState.playersTeamOne.isEmpty) {
          widget.newGameState.addPlayerToTeamOne(user);
        } else {
          if (widget.newGameState.playersTeamTwo.isEmpty) {
            widget.newGameState.addPlayerToTeamTwo(user);
          }
        }
      } else {
        // four players
        if (widget.newGameState.playersTeamOne.length < 2) {
          widget.newGameState.addPlayerToTeamOne(user);
        } else {
          widget.newGameState.addPlayerToTeamTwo(user);
        }
      }
    } else {
      // remove from teams
      bool playerTeamOne = isPlayerInTeamOne(user);
      bool playerTeamTwo = isPlayerInTeamTwo(user);

      if (playerTeamOne) {
        widget.newGameState.removePlayerFromTeamOne(user);
      }
      if (playerTeamTwo) {
        widget.newGameState.removePlayerFromTeamTwo(user);
      }
    }
  }

  bool isPlayerInTeamOne(UserResponse user) {
    return widget.newGameState.playersTeamOne.contains(user);
  }

  bool isPlayerInTeamTwo(UserResponse user) {
    return widget.newGameState.playersTeamTwo.contains(user);
  }

  @override
  void initState() {
    super.initState();
    // tuple test
    widget.newGameState.initializeCheckedPlayers(widget.players!);
    checkSelf();
  }

  void checkSelf() {
    int index = findIndexOfUser();
    UserResponse user = widget.players![index];
    widget.newGameState.setCheckedPlayer(index, true, user.id);
    widget.newGameState.addPlayerToTeamOne(user);
  }

  int findIndexOfUser() {
    int index = 0;
    List<UserResponse> tmpPlayers;
    if (widget.players != null) {
      tmpPlayers = widget.players!;
      for (var i = 0; i < tmpPlayers.length; i++) {
        if (tmpPlayers[i].id == widget.userState.userId) {
          index = i;
          break;
        }
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SizedBox(
        height: 230,
        // add listview with variable two
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: _buildPlayersList(widget.players, widget.newGameState),
        ),
      );
    });
  }
}
