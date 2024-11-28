import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:tuple/tuple.dart';

class PlayersList extends StatefulWidget {
  final UserState userState;
  final List<UserResponse> players;
  final Function(UserResponse userResponse, bool checkedOrNot) playerChecked;

  const PlayersList({
    super.key,
    required this.userState,
    required this.players,
    required this.playerChecked,
  });

  @override
  State<PlayersList> createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  List<Tuple2<UserResponse, bool>> selectedPlayers = [];
  Helpers helpers = Helpers();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.players.length; i++) {
      Tuple2<UserResponse, bool> player = Tuple2(widget.players[i], false);
      selectedPlayers.add(player);
    }
  }

  List<ListTile> _buildPlayersList(List<UserResponse>? users) {
    List<ListTile> list = <ListTile>[];
    for (var i = 0; i < users!.length; i++) {
      if (users[i].isDeleted == false) {
        list.add(ListTile(
          key: Key('player_${users[i].id}'), // Add a unique key here
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${users[i].firstName} ${users[i].lastName}"),
            ],
          ),
          subtitle: Text(users[i].email),
          leading: SizedBox(
            height: 100,
            width: 50,
            child: Image.network(users[i].photoUrl),
          ),
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
                        value: selectedPlayers[i].item2,
                        onChanged: (bool? value) {
                          if (isCheckedLoggedInUser(value, i, users[i]) ==
                              false) {
                            checkBoxChecked(value, i, users[i]);
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
    Tuple2<UserResponse, bool> player =
        Tuple2(widget.players[index], isChecked);
    setState(() {
      selectedPlayers[index] = player;
    });
    widget.playerChecked(user, value!);
  }

  void setTeamsInStore(bool value, int index, UserResponse user) {}

  int findIndexOfUser() {
    int index = 0;
    List<UserResponse> tmpPlayers;

    tmpPlayers = widget.players;
    for (var i = 0; i < tmpPlayers.length; i++) {
      if (tmpPlayers[i].id == widget.userState.userId) {
        index = i;
        break;
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
          key: const Key('playerListScroll'),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: _buildPlayersList(widget.players),
        ),
      );
    });
  }
}
