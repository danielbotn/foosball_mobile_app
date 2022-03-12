import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:provider/provider.dart';

class NewGamePlayers extends StatefulWidget {
  final UserState userState;
  final List<UserResponse>? players;
  NewGamePlayers({Key? key, required this.userState, required this.players})
      : super(key: key);

  @override
  State<NewGamePlayers> createState() => _NewGamePlayersState();
}

class _NewGamePlayersState extends State<NewGamePlayers> {
  late List<bool> _isChecked;

  // create function _buildHistoryList() with players
  List<ListTile> _buildHistoryList(List<UserResponse>? users, NewGameState gameState) {
    List<ListTile> list = <ListTile>[];
    for (var i = 0; i < users!.length; i++) {
      list.add(ListTile(
        // onTap: () => _goToMatchDetailScreen(
        //     history[i]!.matchId, history[i]!.typeOfMatchName, history[i]!.leagueId),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(users[i].firstName + " " + users[i].lastName),
          ],
        ),
        subtitle: Text(users[i].email),
        leading: SizedBox(
            height: 100, width: 50, child: Image.network(users[i].photoUrl)),
        trailing: Container(
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
                      value: gameState.checkedPlayers[i],
                      onChanged: (bool? value) {
                        checkBoxChecked(value, i, users[i]);
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  void checkBoxChecked(bool? value, int index, UserResponse user) {
    final newGameState = Provider.of<NewGameState>(context, listen: false);

    bool tmp = value ?? false;

    setState(() {
      _isChecked[index] = tmp;
    });
    newGameState.setCheckedPlayer(index, tmp);
    setTeamsInStore(tmp, index, user);
  }

  void setTeamsInStore(bool value, int index, UserResponse user) {
    final newGameState = Provider.of<NewGameState>(context, listen: false);
    if (value) {
      // put into teams

      // two players
      if (newGameState.twoOrFourPlayers) {
        if (newGameState.playersTeamOne.length < 1) {
          newGameState.addPlayerToTeamOne(user);
        } else {
          if (newGameState.playersTeamTwo.length < 1) {
            newGameState.addPlayerToTeamTwo(user);
          }
        }
      } else {
        // four players
        if (newGameState.playersTeamOne.length < 2) {
          newGameState.addPlayerToTeamOne(user);
        } else {
          newGameState.addPlayerToTeamTwo(user);
        }
      }
    } else {
      // maybe remove from teams
      bool playerTeamOne = isPlayerInTeamOne(user);
      bool playerTeamTwo = isPlayerInTeamTwo(user);

      if (playerTeamOne) {
        newGameState.removePlayerFromTeamOne(user);
      }
      if (playerTeamTwo) {
        newGameState.removePlayerFromTeamTwo(user);
      }
    }
  }

  bool isPlayerInTeamOne(UserResponse user) {
    final newGameState = Provider.of<NewGameState>(context, listen: false);
    return newGameState.playersTeamOne.contains(user);
  }

  bool isPlayerInTeamTwo(UserResponse user) {
    final newGameState = Provider.of<NewGameState>(context, listen: false);
    return newGameState.playersTeamTwo.contains(user);
  }

  @override
  void initState() {
    super.initState();
    final newGameState = Provider.of<NewGameState>(context, listen: false);
    _isChecked = List<bool>.filled(this.widget.players!.length, false);
    newGameState.initializeCheckedPlayers(this.widget.players!.length);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final newGameState = Provider.of<NewGameState>(context, listen: false);
      return Container(
        height: 230,
        // add listview with variable two
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: _buildHistoryList(this.widget.players, newGameState),
        ),
      );
    });
  }
}
